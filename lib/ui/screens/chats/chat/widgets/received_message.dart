import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/utils/functions.dart';

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({
    Key key,
    @required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final color =
        Theme.of(context).primaryTextTheme.bodyText1.color.withOpacity(0.1);
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: screenWidth * 0.7,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Wrap(
            // alignment: WrapAlignment.end,
            children: [
              Text(
                message.body,
                textAlign: TextAlign.start,
              ),
              // Expanded(child: Container()),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 6, left: 6),
                  child: message.timestamp != null
                      ? Text(
                          "${Functions.getMessageTime(message.timestamp)}",
                          style: TextStyle(fontSize: 10),
                        )
                      : Icon(Icons.access_time_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
