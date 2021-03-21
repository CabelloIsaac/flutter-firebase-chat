import 'package:flutter/material.dart';

class ListTileSecondary extends StatelessWidget {
  const ListTileSecondary(
      {@required this.icon, @required this.backgroundColor});

  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: Icon(
        icon,
        size: 16,
        color: Colors.white,
      ),
    );
  }
}
