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
          icon: Hero(
            tag: _authProvider.dbUser.avatar,
            child: CircleAvatar(
              foregroundImage: _authProvider.dbUser.avatar != null
                  ? NetworkImage(
                      _authProvider.dbUser.avatar,
                    )
                  : null,
              child: Icon(Icons.person),
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
