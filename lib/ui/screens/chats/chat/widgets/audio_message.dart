import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/chats/chat/widgets/timestamp.dart';

class AudioMessage extends StatefulWidget {
  const AudioMessage({
    Key key,
    @required this.message,
  }) : super(key: key);

  final Message message;

  @override
  _AudioMessageState createState() => _AudioMessageState();
}

class _AudioMessageState extends State<AudioMessage> {
  AudioPlayer audioPlayer;
  bool _isPlaying = false;
  bool _isPaused = false;

  double _completedPercentage = 0.0;
  int _totalDuration;
  int _currentDuration;
  Message message;

  @override
  void dispose() {
    audioPlayer.stop().then((value) => audioPlayer.release());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    message = widget.message;
    final screenWidth = MediaQuery.of(context).size.width;

    double messageWidth;
    if (screenWidth < 768)
      messageWidth = screenWidth * 0.7;
    else
      messageWidth = 400;

    bool isSent = message.from == AuthProvider.getCurrentUserUid();
    final receivedBackgrounColor =
        Theme.of(context).primaryTextTheme.bodyText1.color.withOpacity(0.1);
    final sentBackgrounColor = Theme.of(context).primaryColor;
    final textColor = isSent
        ? Theme.of(context).scaffoldBackgroundColor
        : Theme.of(context).primaryTextTheme.bodyText1.color;

    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Align(
        alignment: isSent ? Alignment.bottomRight : Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.all(15),
          width: messageWidth,
          decoration: BoxDecoration(
            color: isSent ? sentBackgrounColor : receivedBackgrounColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: !_isPlaying || _isPaused
                    ? Icon(Icons.play_arrow)
                    : Icon(Icons.pause),
                onPressed: _play,
                color: textColor,
              ),
              Expanded(
                child: Slider(
                  activeColor: textColor,
                  inactiveColor: textColor.withOpacity(0.5),
                  max: _totalDuration != null ? _totalDuration.toDouble() : 0,
                  value: _currentDuration != null
                      ? _currentDuration.toDouble()
                      : 0,
                  min: 0,
                  onChanged: (value) {
                    audioPlayer.seek(Duration(microseconds: value.toInt()));
                  },
                  onChangeEnd: (value) {
                    print(value);
                  },
                ),
              ),
              TimestampIndicator(
                timestamp: message.timestamp,
                textColor: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _play() async {
    if (!_isPlaying) {
      audioPlayer = AudioPlayer();
      audioPlayer.play(message.body);
      setState(() => _isPlaying = true);

      audioPlayer.onPlayerCompletion.listen((_) {
        setState(() {
          _isPlaying = false;
          _completedPercentage = 0.0;
        });
      });

      audioPlayer.onDurationChanged.listen((duration) {
        setState(() {
          _totalDuration = duration.inMicroseconds;
        });
      });

      audioPlayer.onAudioPositionChanged.listen((duration) {
        setState(() {
          _currentDuration = duration.inMicroseconds;
          _completedPercentage =
              _currentDuration.toDouble() / _totalDuration.toDouble() * 100;
          print(_completedPercentage);
        });
      });

      audioPlayer.onNotificationPlayerStateChanged.listen((event) {
        print(event);
        if (event == AudioPlayerState.PAUSED) {
          print("paused");
        }
      });
    } else {
      if (_isPaused) {
        audioPlayer.resume();
        setState(() => _isPaused = false);
      } else {
        audioPlayer.pause();
        setState(() => _isPaused = true);
      }
    }
  }
}
