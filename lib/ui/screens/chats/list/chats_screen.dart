import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Container(
      child: Column(children: [
        Text(_authProvider.firebaseUser.uid.toString()),
        ElevatedButton(
            onPressed: () {
              _authProvider.signOut();
            },
            child: Text("Sign out")),
      ]),
    );
  }
}
