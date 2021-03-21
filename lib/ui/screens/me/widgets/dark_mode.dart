import 'package:flutter/material.dart';

import 'list_title_secondary.dart';

class DarkMode extends StatelessWidget {
  const DarkMode({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text("Modo oscuro"),
      secondary: ListTileSecondary(
        icon: Icons.brightness_2,
        backgroundColor: Colors.grey,
      ),
      value: true,
      onChanged: (value) {},
    );
  }
}
