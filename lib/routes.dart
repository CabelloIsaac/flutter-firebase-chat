import 'package:flutter/material.dart';

import 'record.dart';
import 'ui/screens/auth/login/login_screen.dart';
import 'ui/screens/auth/select_avatar/select_avatar_screen.dart';
import 'ui/screens/change_user_name/change_user_name_screen.dart';
import 'ui/screens/chats/chat/chat_screen.dart';
import 'ui/screens/chats/new/new_chat_screen.dart';
import 'ui/screens/me/my_profile.dart';

class Routes {
  static final routes = {
    LoginScreen.route: (BuildContext context) => LoginScreen(),
    SelectAvatarScreen.route: (BuildContext context) => SelectAvatarScreen(),
    MyProfileScreen.route: (BuildContext context) => MyProfileScreen(),
    ChangeUserNameScreen.route: (BuildContext context) =>
        ChangeUserNameScreen(),
    NewChatScreen.route: (BuildContext context) => NewChatScreen(),
    ChatScreen.route: (BuildContext context) => ChatScreen(),
    "record": (BuildContext context) => RecorderHomeView(title: "asdasd"),
  };
}
