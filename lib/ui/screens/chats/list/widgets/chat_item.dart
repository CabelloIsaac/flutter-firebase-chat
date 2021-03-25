import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/chats/chat/chat_screen.dart';
import 'package:flutter_firebase_chat/ui/screens/image_detail/image_detail_screen.dart';
import 'package:flutter_firebase_chat/utils/functions.dart';
import 'package:provider/provider.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(this.chat);
  final Chat chat;
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatsProvider>(context);

    bool chatHasValidPicture = _chatHasValidPicture();
    String chatPicture = _getChatPicture();

    return ListTile(
      leading: Hero(
        tag: chatPicture.toString(),
        child: GestureDetector(
          onTap: chatHasValidPicture
              ? () {
                  Navigator.pushNamed(context, ImageDetailScreen.route,
                      arguments: chatPicture);
                }
              : null,
          child: CircleAvatar(
            radius: 30,
            foregroundImage: _chatHasValidPicture()
                ? CachedNetworkImageProvider(_getChatPicture())
                : null,
            child: Icon(Icons.person),
          ),
        ),
      ),
      title: Text(_getChatName()),
      subtitle: Row(
        children: [
          Expanded(
              child: Text(
            _getLastMessageBody(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          Text(Functions.getMessageTimestamp(chat.lastMessage.timestamp)),
        ],
      ),
      onTap: () {
        chatProvider.chat = chat;
        Navigator.pushNamed(context, ChatScreen.route);
      },
    );
  }

  bool _chatHasValidPicture() {
    String chatPicture = _getChatPicture();
    return chatPicture != null && chatPicture.isNotEmpty;
  }

  String _getChatPicture() {
    String avatar = "";
    chat.participantsData.forEach((participant) {
      if (!_isLoggedUser(participant.id)) {
        avatar = participant.avatar;
      }
    });
    return avatar;
  }

  String _getChatName() {
    String name = "";
    chat.participantsData.forEach((participant) {
      if (!_isLoggedUser(participant.id)) {
        name = "${participant.name} ${participant.lastName}";
      }
    });
    return name;
  }

  String _getLastMessageBody() {
    String lastMessage = "";

    if (chat.lastMessage.type == "text") {
      if (_isLoggedUser(chat.lastMessage.from)) {
        lastMessage += "Tú: ";
      }
      return lastMessage += chat.lastMessage.body;
    } else if (chat.lastMessage.type == "image") {
      if (_isLoggedUser(chat.lastMessage.from)) {
        lastMessage += "Tú: ";
        return lastMessage += "Enviaste una foto";
      } else {
        return "Envió una foto";
      }
    } else if (chat.lastMessage.type == "audio") {
      if (_isLoggedUser(chat.lastMessage.from)) {
        lastMessage += "Tú: ";
        return lastMessage += "Enviaste un audio";
      } else {
        return "Envió un audio";
      }
    } else {
      if (_isLoggedUser(chat.lastMessage.from)) {
        lastMessage += "Tú: ";
        return lastMessage += "Enviaste un mensje";
      } else {
        return "Envió un mensaje";
      }
    }
  }

  bool _isLoggedUser(String id) {
    String userId = AuthProvider.getCurrentUserUid();
    return id == userId;
  }
}
