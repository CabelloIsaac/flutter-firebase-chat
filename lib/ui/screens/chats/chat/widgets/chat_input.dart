import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    Key key,
  }) : super(key: key);

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  ChatsProvider _chatsProvider;
  TextEditingController _controller = TextEditingController();
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    _chatsProvider = Provider.of<ChatsProvider>(context);

    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.keyboard_voice),
            onPressed: () {
              Navigator.pushNamed(context, "record");
            },
          ),
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              _getImage();
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 4,
              minLines: 1,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                filled: true,
                isCollapsed: true,
                contentPadding: EdgeInsets.all(15),
                hintText: "Escribe un mensaje",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          )
        ],
      ),
    );
  }

  void _sendMessage() {
    String body = _controller.text.trim();
    if (_controller.text.trim().isNotEmpty) {
      Message message = Message(
        body: body,
        from: AuthProvider.getCurrentUserUid(),
        type: "text",
      );

      _chatsProvider.sendTextMessage(message);
      _controller.clear();
    }
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      Message message = Message(
        from: AuthProvider.getCurrentUserUid(),
        type: "image",
      );
      _chatsProvider.sendImageMessage(message, File(pickedFile.path));
    }
  }
}
