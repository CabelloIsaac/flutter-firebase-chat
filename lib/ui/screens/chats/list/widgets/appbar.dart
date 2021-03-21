import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/me/my_profile.dart';
import 'package:flutter_firebase_chat/ui/widgets/title_text.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return AppBar(
      title: TitleText("Chats"),
      actions: [
        IconButton(
          icon: _authProvider.dbUser.avatar == null
              ? CircleAvatar(
                  child: Icon(Icons.person),
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(
                    _authProvider.dbUser.avatar,
                  ),
                ),
          onPressed: () {
            Navigator.pushNamed(context, MyProfileScreen.route);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(AppBar().preferredSize.height);
}
