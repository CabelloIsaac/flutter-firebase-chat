import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'list_title_secondary.dart';

class SignOut extends StatelessWidget {
  const SignOut({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return ListTile(
      title: Text("Cerrar sesión"),
      leading: ListTileSecondary(
        icon: Icons.exit_to_app,
        backgroundColor: Colors.red,
      ),
      onTap: () async {
        await authProvider.signOut();
        Navigator.pop(context);
      },
    );
  }
}
