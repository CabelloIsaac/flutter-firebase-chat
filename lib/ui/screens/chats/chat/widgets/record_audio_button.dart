import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:flutter_firebase_chat/providers/message_input_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class RecordAudioButton extends StatefulWidget {
  const RecordAudioButton({
    Key key,
  }) : super(key: key);

  @override
  _RecordAudioButtonState createState() => _RecordAudioButtonState();
}

class _RecordAudioButtonState extends State<RecordAudioButton> {
  IconData _recordIcon = Icons.mic;
  Color _buttonColor = Colors.blue;

  Directory appDirectory;
  Stream<FileSystemEntity> fileStream;
  List<String> records;
  String filePath = "";
  // Recorder properties
  FlutterAudioRecorder audioRecorder;

  ChatsProvider _chatsProvider;
  MessageInputProvider _messageInputProvider;

  bool _isRecorderSet = false;

  @override
  void dispose() {
    _messageInputProvider.recordingState = RecordingState.UnSet;
    audioRecorder = null;
    super.dispose();
  }

  void initAudioRecorder() {
    if (!_isRecorderSet) {
      _buttonColor = Theme.of(context).primaryColor;
      FlutterAudioRecorder.hasPermissions.then((hasPermision) {
        if (hasPermision) {
          _messageInputProvider.recordingState = RecordingState.Set;
          _recordIcon = Icons.mic;
        }
      });
      _isRecorderSet = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _chatsProvider = Provider.of<ChatsProvider>(context);
    _messageInputProvider = Provider.of<MessageInputProvider>(context);
    initAudioRecorder();
    return IconButton(
      color: _buttonColor,
      icon: Icon(_recordIcon),
      onPressed: () async {
        // Navigator.pushNamed(context, "record");
        await _onRecordButtonPressed();
        setState(() {});
      },
    );
  }

  Future<void> _onRecordButtonPressed() async {
    switch (_messageInputProvider.recordingState) {
      case RecordingState.Set:
        await _recordVoice();
        break;

      case RecordingState.Recording:
        await _stopRecording();

        setState(() {
          _messageInputProvider.recordingState = RecordingState.Stopped;
          _recordIcon = Icons.mic;
          _buttonColor = Theme.of(context).primaryColor;
        });
        break;

      case RecordingState.Stopped:
        await _recordVoice();
        break;

      default:
        break;
    }
  }

  _initRecorder() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    filePath = appDirectory.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.aac';

    print("Recording at $filePath");

    audioRecorder = FlutterAudioRecorder(
      filePath,
      audioFormat: AudioFormat.AAC,
      sampleRate: 8000,
    );
    await audioRecorder.initialized;
  }

  _startRecording() async {
    await audioRecorder.start();
    // await audioRecorder.current(channel: 0);
  }

  _stopRecording() async {
    await audioRecorder.stop();
    _onRecordComplete();
  }

  Future<void> _recordVoice() async {
    if (await FlutterAudioRecorder.hasPermissions) {
      await _initRecorder();

      await _startRecording();

      setState(() {
        _messageInputProvider.recordingState = RecordingState.Recording;
        _recordIcon = Icons.stop;
        _buttonColor = Colors.red;
      });
    }
  }

  _onRecordComplete() {
    Message message = Message(
      body: filePath,
      from: AuthProvider.getCurrentUserUid(),
      type: "audio",
    );

    _chatsProvider.sendAudioMessage(message, File(filePath));
    setState(() {});
  }
}
