import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/utils/functions.dart';

class SentImage extends StatelessWidget {
  const SentImage({
    Key key,
    @required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: screenWidth * 0.7,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Wrap(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(
                  message.body,
                  width: screenWidth * 0.7,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 6, right: 10, bottom: 10),
                  child: message.timestamp != null
                      ? Text(
                          "${Functions.getMessageTime(message.timestamp)}",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white.withOpacity(0.5)),
                        )
                      : Icon(Icons.access_time_rounded,
                          size: 10, color: Colors.white.withOpacity(0.5)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
