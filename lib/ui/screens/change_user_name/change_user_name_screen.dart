import 'package:flutter/material.dart';

import 'widgets/my_form.dart';

class ChangeUserNameScreen extends StatefulWidget {
  static final String route = "/ChangeUserNameScreen";
  @override
  _ChangeUserNameScreenState createState() => _ChangeUserNameScreenState();
}

class _ChangeUserNameScreenState extends State<ChangeUserNameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cambiar mi nombre")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: MyForm(),
      ),
    );
  }
}
