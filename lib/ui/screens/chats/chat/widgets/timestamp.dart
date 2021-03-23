import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/utils/functions.dart';

class TimestampIndicator extends StatelessWidget {
  const TimestampIndicator({
    Key key,
    @required this.timestamp,
    @required this.textColor,
  }) : super(key: key);

  final Timestamp timestamp;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(top: 6, left: 6),
        child: timestamp != null
            ? Text(
                "${Functions.getMessageTime(timestamp)}",
                style: TextStyle(fontSize: 11, color: textColor),
              )
            : Icon(
                Icons.access_time_rounded,
                color: textColor,
                size: 13,
              ),
      ),
    );
  }
}
