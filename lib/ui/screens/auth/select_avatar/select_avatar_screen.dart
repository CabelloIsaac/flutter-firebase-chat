import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/complete_user_data_provider.dart';
import 'package:flutter_firebase_chat/ui/widgets/title_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SelectAvatarScreen extends StatefulWidget {
  static final String route = "/SelectAvatarScreen";

  @override
  _SelectAvatarScreenState createState() => _SelectAvatarScreenState();
}

class _SelectAvatarScreenState extends State<SelectAvatarScreen> {
  File _image;
  final picker = ImagePicker();
  CompleteUserDataProvider _completeUserDataProvider;

  @override
  Widget build(BuildContext context) {
    _completeUserDataProvider = Provider.of<CompleteUserDataProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleText("Selecciona tu foto de perfil."),
              GestureDetector(
                onTap: _getImage,
                child: CircleAvatar(
                  radius: 100,
                  child: _image == null
                      ? Icon(
                          Icons.camera_alt,
                          size: 75,
                        )
                      : Container(),
                  backgroundImage: _image == null ? null : FileImage(_image),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _image == null ? _skipAvatarUpload : _uploadAvatar,
                  child: Text("Continuar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _skipAvatarUpload() {
    print("Skipping");
  }

  void _uploadAvatar() {
    // _completeUserDataProvider
  }
}