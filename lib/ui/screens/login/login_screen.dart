import 'package:flutter/material.dart';

import 'widgets/my_form.dart';
import 'widgets/header.dart';

class LoginScreen extends StatelessWidget {
  static final String route = "/LoginScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(40),
              child: Center(
                child: Column(
                  children: [
                    Header(),
                    SizedBox(height: 40),
                    MyForm(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
