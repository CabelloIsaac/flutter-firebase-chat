import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/ui/screens/auth/select_avatar/select_avatar_screen.dart';

import 'ui/screens/auth/login/login_screen.dart';

class Routes {
  static final routes = {
    LoginScreen.route: (BuildContext context) => LoginScreen(),
    SelectAvatarScreen.route: (BuildContext context) => SelectAvatarScreen(),
  };
}
