import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/db_user.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    final bool loadingDBUserData = _authProvider.loadingDBUserData;
    final DBUser dbUser = _authProvider.dbUser;

    if (loadingDBUserData) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      if (dbUser == null) {
        return Text("User doesn't exists");
      } else {
        return Text("Name is: ${dbUser.name}");
      }
    }
  }
}
