import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/me/my_profile.dart';
import 'package:flutter_firebase_chat/ui/widgets/title_text.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => new Size.fromHeight(AppBar().preferredSize.height);
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  ChatsProvider _chatsProvider;
  Chat _chat;
  @override
  Widget build(BuildContext context) {
    _chatsProvider = Provider.of<ChatsProvider>(context);
    _chat = _chatsProvider.chat;

    bool chatHasValidPicture = _chatHasValidPicture();
    String chatPicture = getChatPicture();

    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          CircleAvatar(
            child: !chatHasValidPicture ? Icon(Icons.person) : null,
            backgroundImage:
                chatHasValidPicture ? NetworkImage(chatPicture) : null,
          ),
          SizedBox(width: 10),
          Text(getChatName()),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.info,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  bool _chatHasValidPicture() {
    String chatPicture = getChatPicture();
    return chatPicture != null && chatPicture.isNotEmpty;
  }

  String getChatPicture() {
    String avatar = "";
    _chat.participantsData.forEach((participant) {
      if (!_isLoggedUser(participant.id)) {
        avatar = participant.avatar;
      }
    });
    return avatar;
  }

  String getChatName() {
    String name = "";
    _chat.participantsData.forEach((participant) {
      if (!_isLoggedUser(participant.id)) {
        name = "${participant.name} ${participant.lastName}";
      }
    });
    return name;
  }

  bool _isLoggedUser(String id) {
    String userId = AuthProvider.getCurrentUserUid();
    return id == userId;
  }
}
