import 'package:flutter/material.dart';

class NewChatScreen extends StatefulWidget {
  static final String route = "/NewChatScreen";
  @override
  _NewChatScreenState createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nuevo chat")),
      body: Container(),
    );
  }
}
