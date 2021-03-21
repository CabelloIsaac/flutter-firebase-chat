import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/db_user.dart';
import 'package:flutter_firebase_chat/providers/users_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/user_item.dart';

class NewChatScreen extends StatefulWidget {
  static final String route = "/NewChatScreen";
  @override
  _NewChatScreenState createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    usersProvider.loadUsers();
    return Scaffold(
      appBar: AppBar(title: Text("Nuevo chat")),
      body: ListView.builder(
        padding: EdgeInsets.only(bottom: 65),
        itemCount: usersProvider.users.length,
        itemBuilder: (context, index) {
          DBUser user = usersProvider.users[index];
          return UserItem(user);
        },
      ),
    );
  }
}
