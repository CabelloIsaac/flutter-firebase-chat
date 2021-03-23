import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/error_message.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/my_form.dart';
import 'widgets/header.dart';

class LoginScreen extends StatelessWidget {
  static final String route = "/LoginScreen";
  @override
  Widget build(BuildContext context) {
    var _pageSize = MediaQuery.of(context).size.height;
    var _notifySize = MediaQuery.of(context).padding.top;

    final authProvider = Provider.of<AuthProvider>(context);
    final authenticating = authProvider.status == Status.Authenticating;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: _pageSize - _notifySize,
                padding: EdgeInsets.all(40),
                child: Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Header(),
                      SizedBox(height: 40),
                      MyForm(),
                      ErrorMessage()
                    ],
                  ),
                ),
              ),
            ),
            if (authenticating) LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
