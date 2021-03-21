import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/ui/widgets/title_text.dart';
import 'package:provider/provider.dart';

import 'widgets/list_title_secondary.dart';
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
              SwitchListTile(
                title: Text("Modo oscuro"),
                secondary: ListTileSecondary(
                  icon: Icons.brightness_2,
                  backgroundColor: Colors.grey,
                ),
                value: true,
                onChanged: (value) {},
              ),
              SignOut()
            ],
          ),
        ),
      ),
    );
  }
}
