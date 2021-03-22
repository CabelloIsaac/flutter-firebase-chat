import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/utils/functions.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    @required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    bool isSent = message.from == AuthProvider.getCurrentUserUid();
    final receivedBackgrounColor =
        Theme.of(context).primaryTextTheme.bodyText1.color.withOpacity(0.1);
    final sentBackgrounColor = Theme.of(context).primaryColor;
    final textColor = isSent
        ? Theme.of(context).scaffoldBackgroundColor
        : Theme.of(context).primaryTextTheme.bodyText1.color;

    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Align(
        alignment: isSent ? Alignment.bottomRight : Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: screenWidth * 0.7,
          decoration: BoxDecoration(
            color: isSent ? sentBackgrounColor : receivedBackgrounColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Wrap(
            // alignment: WrapAlignment.end,
            children: [
              Text(
                message.body,
                textAlign: TextAlign.start,
                style: TextStyle(color: textColor),
              ),
              // Expanded(child: Container()),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 6, left: 6),
                  child: message.timestamp != null
                      ? Text(
                          "${Functions.getMessageTime(message.timestamp)}",
                          style: TextStyle(fontSize: 11, color: textColor),
                        )
                      : Icon(
                          Icons.access_time_rounded,
                          color: textColor,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
