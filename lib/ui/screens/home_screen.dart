import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/auth/complete_user_data/complete_user_data_screen.dart';
import 'package:flutter_firebase_chat/ui/screens/chats/list/chats_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    final bool loadingDBUserData = _authProvider.loadingDBUserData;
    final bool userExists = _authProvider.userExists;

    if (loadingDBUserData) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      if (userExists) {
        return ChatsScreen();
      } else {
        return CompleteUserDataScreen();
      }
    }
  }
}
