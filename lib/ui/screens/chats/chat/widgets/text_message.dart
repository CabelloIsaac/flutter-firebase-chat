import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';

import 'timestamp.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    @required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
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
          child: Wrap(
            children: [
              Text(
                message.body,
                textAlign: TextAlign.start,
                style: TextStyle(color: textColor),
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
}
