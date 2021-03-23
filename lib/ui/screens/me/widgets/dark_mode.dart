import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'list_title_secondary.dart';
import 'package:flutter_firebase_chat/providers/settings_provider.dart';

class DarkMode extends StatelessWidget {
  const DarkMode({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BoxEvent>(
        stream: Hive.box("settings").watch(key: "darkTheme"),
        builder: (context, snapshot) {
          return SwitchListTile(
            secondary: ListTileSecondary(
              icon: Icons.brightness_2,
              backgroundColor: Colors.grey,
            ),
            value: SettingsProvider.isDarkTheme(),
            onChanged: (value) {
              SettingsProvider.setDarkTheme(value);
            },
            title: Text("Tema oscuro"),
          );
        });
  }
}
