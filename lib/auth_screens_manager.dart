import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'ui/screens/login/login_screen.dart';

class AuthScreensManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, AuthProvider authProvider, _) {
        switch (authProvider.status) {
          case Status.Authenticated:
            return Container(
              child: Text("Logged"),
            );
          default:
            return LoginScreen();
        }
      },
    );
  }
}
