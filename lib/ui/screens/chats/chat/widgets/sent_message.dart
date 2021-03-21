import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';

class SentMessage extends StatelessWidget {
  const SentMessage({
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
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: screenWidth / 2,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Wrap(
            // alignment: WrapAlignment.end,
            children: [
              Text(
                message.body,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Expanded(child: Container()),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 6, left: 6),
                  child: Text(
                    "12:22 pm",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                    ),
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
