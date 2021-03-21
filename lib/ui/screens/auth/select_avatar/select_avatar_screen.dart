import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/ui/widgets/title_text.dart';

class SelectAvatarScreen extends StatefulWidget {
  static final String route = "/SelectAvatarScreen";

  @override
  _SelectAvatarScreenState createState() => _SelectAvatarScreenState();
}

class _SelectAvatarScreenState extends State<SelectAvatarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleText("Selecciona tu foto de perfil."),
            GestureDetector(
              child: CircleAvatar(
                radius: 100,
                child: Icon(
                  Icons.camera_alt,
                  size: 75,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Continuar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
