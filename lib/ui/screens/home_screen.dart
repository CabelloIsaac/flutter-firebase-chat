import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/auth/complete_user_data/complete_user_data_screen.dart';
import 'package:flutter_firebase_chat/ui/screens/chats/chat/chat_screen.dart';
import 'package:flutter_firebase_chat/ui/screens/chats/list/chats_screen.dart';
import 'package:flutter_firebase_chat/ui/screens/me/my_profile.dart';
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
        return ResponsiveLayout();
      } else {
        return CompleteUserDataScreen();
      }
    }
  }
}

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 768)
      return ChatsScreen();
    else if (width >= 768 && width < 1280)
      return Row(
        children: [
          Expanded(child: ChatsScreen()),
          SectionDivider(),
          Expanded(child: ChatScreen(), flex: 2),
        ],
      );
    else
      return Row(
        children: [
          Expanded(child: ChatsScreen()),
          SectionDivider(),
          Expanded(child: ChatScreen(), flex: 2),
          SectionDivider(),
          Expanded(child: MyProfileScreen()),
        ],
      );
  }
}

class SectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      color:
          Theme.of(context).primaryTextTheme.bodyText1.color.withOpacity(0.1),
    );
  }
}
