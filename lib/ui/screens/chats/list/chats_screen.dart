import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/appbar.dart';
import 'widgets/chat_item.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatsProvider = Provider.of<ChatsProvider>(context);
    chatsProvider.loadChats();
    return Scaffold(
      appBar: MyAppBar(),
      body: ListView.builder(
        padding: EdgeInsets.only(bottom: 65),
        itemCount: chatsProvider.chats.length,
        itemBuilder: (context, index) {
          Chat chat = chatsProvider.chats[index];
          return ChatItem(chat);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          chatsProvider.createTestChat();
        },
        label: Text("Iniciar chat"),
        icon: Icon(Icons.edit),
      ),
    );
  }
}
