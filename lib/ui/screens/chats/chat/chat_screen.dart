import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:flutter_firebase_chat/ui/widgets/empty_list_indicator.dart';
import 'package:flutter_firebase_chat/utils/functions.dart';
import 'package:provider/provider.dart';

import 'widgets/appbar.dart';
import 'widgets/chat_input.dart';
import 'widgets/message_day_divider.dart';
import 'widgets/message_item.dart';

class ChatScreen extends StatefulWidget {
  static final String route = "/ChatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatsProvider _chatsProvider;
  @override
  Widget build(BuildContext context) {
    _chatsProvider = Provider.of<ChatsProvider>(context);
    final messages = _chatsProvider.messages;

    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.only(top: 20),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    Message currentMessage = messages[index];

                    List<Widget> widgets = [MessageItem(messages[index])];

                    if (currentMessage.timestamp != null) {
                      if (index < messages.length - 1) {
                        bool differentDays = false;
                        Message nextMessage = messages[index + 1];

                        differentDays = Functions.messagesAreDifferentDays(
                            nextMessage, currentMessage);

                        if (differentDays)
                          widgets.insert(0, MessageDayDivider(currentMessage));
                      } else if (index == messages.length - 1) {
                        widgets.insert(0, MessageDayDivider(currentMessage));
                      }
                    }

                    return Column(
                      children: widgets,
                    );
                  },
                ),
                if (messages.isEmpty)
                  EmptyListIndicator(
                    icon: "res/icons/empty_messages.svg",
                    message: "Escribe un mensaje, o envía un audio o una foto.",
                  ),
              ],
            ),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}
