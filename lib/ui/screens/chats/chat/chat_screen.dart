import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/appbar.dart';

class ChatScreen extends StatefulWidget {
  static final String route = "/ChatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatsProvider _chatsProvider;
  Chat _chat;
  @override
  Widget build(BuildContext context) {
    _chatsProvider = Provider.of<ChatsProvider>(context);
    _chat = _chatsProvider.chat;

    return Scaffold(
      appBar: MyAppBar(),
    );
  }
}
