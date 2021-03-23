import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:provider/provider.dart';

import 'audio_message.dart';
import 'image_message.dart';
import 'text_message.dart';

class MessageItem extends StatelessWidget {
  MessageItem(this.message);
  final Message message;
  @override
  Widget build(BuildContext context) {
    final chatsProvider = Provider.of<ChatsProvider>(context);

    return Dismissible(
      key: Key(message.id),
      confirmDismiss: (value) async {
        return _showConfirmationDialog(context);
      },
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        chatsProvider.deleteMessage(message);
      },
      child: _getMessageWidget(),
    );
  }

  Widget _getMessageWidget() {
    if (message.type == "text") {
      return TextMessage(message: message);
    } else if (message.type == "image") {
      return ImageMessage(message: message);
    } else if (message.type == "audio") {
      return AudioMessage(message: message);
    } else {
      return Text(message.body);
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text("¿Quieres borrar este mensaje?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Esta acción no se puede deshacer."),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: Text('Borrar'),
              onPressed: () async {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
    if (result == null) return false;
    return result;
  }
}
