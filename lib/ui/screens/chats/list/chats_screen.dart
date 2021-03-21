import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/appbar.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: MyAppBar(),
      body: ListView.builder(
        padding: EdgeInsets.only(bottom: 65),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ChatItem(Chat());
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Iniciar chat"),
        icon: Icon(Icons.edit),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem(Chat chat);

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(_authProvider.dbUser.avatar),
      ),
      title: Text("Luimar Calzadilla"),
      subtitle: Text("Este es el ultimo mensaje"),
    );
  }
}
