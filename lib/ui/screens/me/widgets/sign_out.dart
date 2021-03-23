import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'list_title_secondary.dart';

class SignOut extends StatefulWidget {
  const SignOut({
    Key key,
  }) : super(key: key);

  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  AuthProvider _authProvider;
  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    return ListTile(
      title: Text("Cerrar sesión"),
      leading: ListTileSecondary(
        icon: Icons.exit_to_app,
        backgroundColor: Colors.red,
      ),
      onTap: _showSignOutDialog,
    );
  }

  Future<void> _showSignOutDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('Cerrar sesión'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Deseas cerrar la sesión actual?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Cerrar sesión'),
              onPressed: () async {
                await _authProvider.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
