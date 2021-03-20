import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ErrorMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return authProvider.errorMessage != null && authProvider.errorMessage.error
        ? Column(
            children: [
              SizedBox(height: 10),
              Container(
                child: Text(
                  "${authProvider.errorMessage.message}",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        : Container();
  }
}
