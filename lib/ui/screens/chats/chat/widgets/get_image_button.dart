import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GetImageButton extends StatefulWidget {
  const GetImageButton({
    Key key,
  }) : super(key: key);

  @override
  _GetImageButtonState createState() => _GetImageButtonState();
}

class _GetImageButtonState extends State<GetImageButton> {
  final picker = ImagePicker();
  ChatsProvider _chatsProvider;
  @override
  Widget build(BuildContext context) {
    _chatsProvider = Provider.of<ChatsProvider>(context);
    return IconButton(
      color: Colors.blue,
      icon: Icon(Icons.camera_alt),
      onPressed: () {
        _getImage();
      },
    );
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
