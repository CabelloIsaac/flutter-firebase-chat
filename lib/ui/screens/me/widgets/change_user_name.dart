import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/ui/screens/change_user_name/change_user_name_screen.dart';

import 'list_title_secondary.dart';

class ChangeUserName extends StatelessWidget {
  const ChangeUserName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Cambiar mi nombre"),
      leading: ListTileSecondary(
        icon: Icons.edit,
        backgroundColor: Colors.green,
      ),
      onTap: () {
        Navigator.pushNamed(context, ChangeUserNameScreen.route);
      },
      trailing: Icon(Icons.chevron_right),
    );
  }
}
