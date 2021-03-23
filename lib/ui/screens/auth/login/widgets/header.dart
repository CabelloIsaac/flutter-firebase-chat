import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "res/icons/quick-square-quick.svg",
          height: 100,
        ),
        SizedBox(height: 20),
        Text(
          "${Constants.APP_NAME} Chat",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
