import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/auth/complete_user_data/complete_user_data_screen.dart';
import 'package:flutter_firebase_chat/ui/screens/chats/chat/chat_screen.dart';
import 'package:flutter_firebase_chat/ui/screens/chats/list/chats_screen.dart';
import 'package:flutter_firebase_chat/ui/screens/me/my_profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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

    return Row(
      children: [
        Expanded(
          child: ChatsScreen(),
        ),
        if (width > 768) SectionDivider(),
        if (width > 768) Expanded(child: ChatScreen()),
        if (width > 1280) SectionDivider(),
        if (width > 1280) Expanded(child: MyProfileScreen()),
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
