import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.keyboard_voice),
            onPressed: () {},
          ),
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              maxLines: 4,
              minLines: 1,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                filled: true,
                isCollapsed: true,
                contentPadding: EdgeInsets.all(15),
                hintText: "Escribe un mensaje",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.send),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
