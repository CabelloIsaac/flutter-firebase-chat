import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    String avatar = authProvider.dbUser.avatar;
    return Stack(
      children: [
        CircleAvatar(
          radius: 55,
          child: avatar == null
              ? Icon(
                  Icons.person,
                  size: 50,
                )
              : Container(),
          backgroundImage: avatar == null ? null : NetworkImage(avatar),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                color: Color.fromRGBO(229, 229, 229, 1.0),
                borderRadius: BorderRadius.circular(
                  50.0,
                ),
              ),
              child: Icon(
                Icons.camera_alt,
                size: 25.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
