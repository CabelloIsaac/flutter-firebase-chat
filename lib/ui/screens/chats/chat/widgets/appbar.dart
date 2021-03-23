import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase_chat/ui/screens/image_detail/image_detail_screen.dart';

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

    return GestureDetector(
      onTap: chatHasValidPicture
          ? () {
              Navigator.pushNamed(context, ImageDetailScreen.route,
                  arguments: chatPicture);
            }
          : null,
      child: AppBar(
        elevation: 1.0,
        titleSpacing: 0,
        title: Row(
          children: [
            Hero(
              tag: chatPicture,
              child: CircleAvatar(
                child: !chatHasValidPicture ? Icon(Icons.person) : null,
                backgroundImage:
                    chatHasValidPicture ? NetworkImage(chatPicture) : null,
              ),
            ),
            SizedBox(width: 10),
            Text(getChatName()),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Vaciar chat', 'Eliminar chat'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Vaciar chat':
        _chatsProvider.emptyChat();
        break;
      case 'Eliminar chat':
        _deleteChat();
        break;
    }
  }

  void _deleteChat() {
    _chatsProvider.deleteChat();
    Navigator.pop(context);
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
