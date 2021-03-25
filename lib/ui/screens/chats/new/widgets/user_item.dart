import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/models/db_user.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/chats/chat/chat_screen.dart';
import 'package:flutter_firebase_chat/utils/functions.dart';
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
  double width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    bool userHasValidAvatar = _userHasValidAvatar();

    _authProvider = Provider.of<AuthProvider>(context);
    _chatsProvider = Provider.of<ChatsProvider>(context);

    return ListTile(
      leading: CircleAvatar(
        child: !userHasValidAvatar ? Icon(Icons.person) : null,
        backgroundImage: userHasValidAvatar
            ? CachedNetworkImageProvider(widget.user.avatar)
            : null,
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

    _chatsProvider.chat = chat;

    if (width < 768)
      Navigator.pushNamed(context, ChatScreen.route);
    else
      Navigator.pop(context);
  }

  Chat _createChatObject() {
    String id =
        Functions.generateChatIdFromParticipants(_getListOfParticipantsIds());

    return Chat(
      id: id,
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
