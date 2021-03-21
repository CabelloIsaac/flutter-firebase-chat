import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';

import 'received_message.dart';
import 'sent_message.dart';

class MessageItem extends StatelessWidget {
  MessageItem(this.message);
  final Message message;
  @override
  Widget build(BuildContext context) {
    if (message.from == AuthProvider.getCurrentUserUid())
      return SentMessage(message: message);
    else
      return ReceivedMessage(message: message);
  }
}
