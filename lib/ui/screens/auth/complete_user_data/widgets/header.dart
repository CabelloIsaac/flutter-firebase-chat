import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/ui/widgets/title_text.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("¿Cómo te llamas?"),
        SizedBox(height: 20),
        Text("Introduce tu nombre y tu apellido."),
      ],
    );
  }
}
