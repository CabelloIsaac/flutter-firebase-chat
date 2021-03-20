import 'package:flutter/material.dart';

import 'widgets/my_form.dart';
import 'widgets/header.dart';

class LoginScreen extends StatelessWidget {
  static final String route = "/LoginScreen";
  @override
  Widget build(BuildContext context) {
    var _pageSize = MediaQuery.of(context).size.height;
    var _notifySize = MediaQuery.of(context).padding.top;

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
                    children: [
                      Expanded(child: Container()),
                      Header(),
                      SizedBox(height: 40),
                      MyForm(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
