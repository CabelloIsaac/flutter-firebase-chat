import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(this.chat);
  final Chat chat;
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);

    bool chatHasValidPicture = _chatHasValidPicture();
    String chatPicture = getChatPicture();

    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: !chatHasValidPicture ? Icon(Icons.person) : null,
        backgroundImage: chatHasValidPicture ? NetworkImage(chatPicture) : null,
      ),
      title: Text(getChatName()),
      subtitle: Text(getLastMessageBody()),
      onTap: () {},
    );
  }

  bool _chatHasValidPicture() {
    String chatPicture = getChatPicture();
    return chatPicture != null && chatPicture.isNotEmpty;
  }

  String getChatPicture() {
    String avatar = "";
    chat.participantsData.forEach((participant) {
      if (!_isLoggedUser(participant.id)) {
        avatar = participant.avatar;
      }
    });
    return avatar;
  }

  String getChatName() {
    String name = "";
    chat.participantsData.forEach((participant) {
      if (!_isLoggedUser(participant.id)) {
        name = "${participant.name} ${participant.lastName}";
      }
    });
    return name;
  }

  String getLastMessageBody() {
    String lastMessage = "";
    if (_isLoggedUser(chat.lastMessage.from)) {
      lastMessage += "Tú: ";
    }
    return lastMessage += chat.lastMessage.body;
  }

  bool _isLoggedUser(String id) {
    String userId = AuthProvider.getCurrentUserUid();
    return id == userId;
  }
}
