import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UserName extends StatelessWidget {
  const UserName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    String fullName =
        "${authProvider.dbUser.name} ${authProvider.dbUser.lastName}";
    return Text(
      fullName,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
