import 'package:flutter/material.dart';

class ChangeUserNameScreen extends StatefulWidget {
  static final String route = "/ChangeUserNameScreen";
  @override
  _ChangeUserNameScreenState createState() => _ChangeUserNameScreenState();
}

class _ChangeUserNameScreenState extends State<ChangeUserNameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cambiar ni nombre")),
      body: Column(),
    );
  }
}
