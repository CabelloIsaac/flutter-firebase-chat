import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'ui/screens/auth/login/login_screen.dart';

class AuthScreensManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, AuthProvider authProvider, _) {
        switch (authProvider.status) {
          case Status.Authenticated:
            return HomeScreen();
          default:
            return LoginScreen();
        }
      },
    );
  }
}
