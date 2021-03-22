import 'package:flutter/widgets.dart';

enum RecordingState {
  UnSet,
  Set,
  Recording,
  Stopped,
}

class MessageInputProvider with ChangeNotifier {
  String _text = "";
  RecordingState _recordingState = RecordingState.UnSet;

  String get text => _text;
  RecordingState get recordingState => _recordingState;

  set text(String value) {
    _text = value;
    notifyListeners();
  }

  set recordingState(RecordingState value) {
    _recordingState = value;
    notifyListeners();
  }
}
