import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/chats/new/new_chat_screen.dart';
import 'package:flutter_firebase_chat/ui/widgets/empty_list_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'widgets/appbar.dart';
import 'widgets/chat_item.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatsProvider = Provider.of<ChatsProvider>(context);
    chatsProvider.loadChats();
    List<Chat> chats = chatsProvider.chats;
    return Scaffold(
      appBar: MyAppBar(),
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(bottom: 65),
            itemCount: chats.length,
            itemBuilder: (context, index) {
              Chat chat = chats[index];
              return ChatItem(chat);
            },
          ),
          if (chats.isEmpty)
            EmptyListIndicator(
              icon: "res/icons/empty_chats.svg",
              message: "Cuando inicies una conversación nueva, aparecerá aquí.",
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // chatsProvider.createTestChat();
          Navigator.pushNamed(context, NewChatScreen.route);
        },
        label: Text("Iniciar chat"),
        icon: Icon(Icons.message),
      ),
    );
  }
}
