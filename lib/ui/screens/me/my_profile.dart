import 'package:flutter/material.dart';

import 'widgets/dark_mode.dart';
import 'widgets/profile_picture.dart';
import 'widgets/sign_out.dart';
import 'widgets/user_name.dart';

class MyProfileScreen extends StatefulWidget {
  static final String route = "/MyProfileScreen";
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yo")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ProfilePicture(),
              SizedBox(height: 20),
              UserName(),
              SizedBox(height: 40),
              DarkMode(),
              SignOut(),
            ],
          ),
        ),
      ),
    );
  }
}
