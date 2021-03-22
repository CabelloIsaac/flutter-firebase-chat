import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/providers/chats_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class RecordAudioButton extends StatefulWidget {
  const RecordAudioButton({
    Key key,
  }) : super(key: key);

  @override
  _RecordAudioButtonState createState() => _RecordAudioButtonState();
}

enum RecordingState {
  UnSet,
  Set,
  Recording,
  Stopped,
}

class _RecordAudioButtonState extends State<RecordAudioButton> {
  IconData _recordIcon = Icons.mic;
  RecordingState _recordingState = RecordingState.UnSet;

  Directory appDirectory;
  Stream<FileSystemEntity> fileStream;
  List<String> records;
  String filePath = "";
  // Recorder properties
  FlutterAudioRecorder audioRecorder;

  ChatsProvider _chatsProvider;

  @override
  void initState() {
    super.initState();

    FlutterAudioRecorder.hasPermissions.then((hasPermision) {
      if (hasPermision) {
        _recordingState = RecordingState.Set;
        _recordIcon = Icons.mic;
      }
    });

    records = [];
    getApplicationDocumentsDirectory().then((value) {
      appDirectory = value;
      appDirectory.list().listen((onData) {
        records.add(onData.path);
      }).onDone(() {
        records = records.reversed.toList();
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _recordingState = RecordingState.UnSet;
    audioRecorder = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _chatsProvider = Provider.of<ChatsProvider>(context);
    return IconButton(
      color: Colors.blue,
      icon: Icon(_recordIcon),
      onPressed: () async {
        await _onRecordButtonPressed();
        setState(() {});
      },
    );
  }

  Future<void> _onRecordButtonPressed() async {
    switch (_recordingState) {
      case RecordingState.Set:
        await _recordVoice();
        break;

      case RecordingState.Recording:
        await _stopRecording();
        _recordingState = RecordingState.Stopped;
        _recordIcon = Icons.mic;
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
      _recordingState = RecordingState.Recording;
      _recordIcon = Icons.stop;
    } else {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please allow recording from settings.'),
      ));
    }
  }

  _onRecordComplete() {
    // records.clear();
    // appDirectory.list().listen((onData) {
    //   records.add(onData.path);
    // }).onDone(() {
    //   records.sort();
    //   records = records.reversed.toList();
    //   print(records.first);

    // });
    Message message = Message(
      body: filePath,
      from: AuthProvider.getCurrentUserUid(),
      type: "audio",
    );

    _chatsProvider.sendAudioMessage(message, File(filePath));
    setState(() {});
  }
}
