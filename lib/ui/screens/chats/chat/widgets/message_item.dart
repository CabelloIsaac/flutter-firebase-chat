import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';

import 'audio_message.dart';
import 'image_message.dart';
import 'text_message.dart';

class MessageItem extends StatelessWidget {
  MessageItem(this.message);
  final Message message;
  @override
  Widget build(BuildContext context) {
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
}
