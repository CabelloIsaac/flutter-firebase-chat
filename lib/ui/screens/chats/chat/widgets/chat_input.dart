import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:flutter_firebase_chat/providers/message_input_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'get_image_button.dart';
import 'record_audio_button.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    Key key,
  }) : super(key: key);

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  ChatsProvider _chatsProvider;
  MessageInputProvider _messageInputProvider;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _chatsProvider = Provider.of<ChatsProvider>(context);
    _messageInputProvider = Provider.of<MessageInputProvider>(context);

    bool recordingAudio =
        _messageInputProvider.recordingState == RecordingState.Recording;

    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          recordingAudio
              ? RecordingAudioIndicator()
              : Expanded(
                  child: Row(
                    children: [
                      GetImageButton(),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 4,
                          minLines: 1,
                          textInputAction: TextInputAction.newline,
                          onChanged: (s) => setState(() => {}),
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
                    ],
                  ),
                ),
          _controller.text.trim().isNotEmpty
              ? IconButton(
                  color: Colors.blue,
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                )
              : RecordAudioButton(),
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
}

class RecordingAudioIndicator extends StatelessWidget {
  const RecordingAudioIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          "Grabando audio",
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
