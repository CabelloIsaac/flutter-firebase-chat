import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/image_detail/image_detail_screen.dart';

import 'timestamp.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({
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

    return Hero(
      tag: message.body,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Align(
          alignment: isSent ? Alignment.bottomRight : Alignment.bottomLeft,
          child: Container(
            width: screenWidth * 0.7,
            decoration: BoxDecoration(
              color: isSent ? sentBackgrounColor : receivedBackgrounColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ImageDetailScreen.route,
                        arguments: message.body);
                  },
                  child: ClipRRect(
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
                ),
                TimestampIndicator(
                  timestamp: message.timestamp,
                  textColor: textColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
