import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/models/db_user.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/chats/chat/chat_screen.dart';
import 'package:provider/provider.dart';

class UserItem extends StatefulWidget {
  const UserItem(this.user);
  final DBUser user;

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  AuthProvider _authProvider;
  ChatsProvider _chatsProvider;

  @override
  Widget build(BuildContext context) {
    bool userHasValidAvatar = _userHasValidAvatar();

    _authProvider = Provider.of<AuthProvider>(context);
    _chatsProvider = Provider.of<ChatsProvider>(context);

    return ListTile(
      leading: CircleAvatar(
        child: !userHasValidAvatar ? Icon(Icons.person) : null,
        backgroundImage:
            userHasValidAvatar ? NetworkImage(widget.user.avatar) : null,
      ),
      title: Text(getUserName()),
      onTap: _openChatScreen,
    );
  }

  bool _userHasValidAvatar() {
    String avatar = widget.user.avatar;
    return avatar != null && avatar.isNotEmpty;
  }

  String getUserName() => "${widget.user.name} ${widget.user.lastName}";

  void _openChatScreen() {
    Chat chat = _createChatObject();

    print(chat.participants);
    _chatsProvider.chat = chat;
    Navigator.pushNamed(context, ChatScreen.route);
  }

  Chat _createChatObject() {
    return Chat(
      participants: _getListOfParticipantsIds(),
      participantsData: _getListOfParticipantsData(),
      type: "chat",
    );
  }

  List<String> _getListOfParticipantsIds() {
    return [
      widget.user.id,
      _authProvider.dbUser.id,
    ];
  }

  List<ParticipantsData> _getListOfParticipantsData() {
    return [
      _createParticipantsData(widget.user),
      _createParticipantsData(_authProvider.dbUser),
    ];
  }

  ParticipantsData _createParticipantsData(DBUser user) {
    return ParticipantsData(
      id: user.id,
      avatar: user.avatar,
      lastName: user.lastName,
      name: user.name,
    );
  }
}
