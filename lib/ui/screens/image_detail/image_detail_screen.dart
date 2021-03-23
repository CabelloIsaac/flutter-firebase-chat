import 'package:flutter/material.dart';

class ImageDetailScreen extends StatelessWidget {
  static final String route = "/ImageDetailScreen";
  @override
  Widget build(BuildContext context) {
    final url = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: InteractiveViewer(child: Image.network(url)),
        ),
      ),
    );
  }
}
