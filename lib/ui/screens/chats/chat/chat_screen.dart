import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/chats/chat/widgets/sent_message.dart';
import 'package:provider/provider.dart';

import 'widgets/appbar.dart';
import 'widgets/chat_input.dart';
import 'widgets/received_message.dart';

class ChatScreen extends StatefulWidget {
  static final String route = "/ChatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatsProvider _chatsProvider;
  @override
  Widget build(BuildContext context) {
    _chatsProvider = Provider.of<ChatsProvider>(context);
    final messages = _chatsProvider.messages;

    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageItem(messages[index]);
              },
            ),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  MessageItem(this.message);
  final Message message;
  @override
  Widget build(BuildContext context) {
    if (message.from == AuthProvider.getCurrentUserUid())
      return SentMessage(message: message);
    else
      return ReceivedMessage(message: message);
  }
}
