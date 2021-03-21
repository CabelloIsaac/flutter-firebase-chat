import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/complete_user_data_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/auth/login/widgets/loading_indicator.dart';
import 'package:flutter_firebase_chat/ui/widgets/title_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SelectAvatarScreen extends StatefulWidget {
  static final String route = "/SelectAvatarScreen";

  @override
  _SelectAvatarScreenState createState() => _SelectAvatarScreenState();
}

class _SelectAvatarScreenState extends State<SelectAvatarScreen> {
  File _avatar;
  final picker = ImagePicker();
  CompleteUserDataProvider _completeUserDataProvider;

  @override
  Widget build(BuildContext context) {
    _completeUserDataProvider = Provider.of<CompleteUserDataProvider>(context);
    _avatar = _completeUserDataProvider.avatar;
    bool loading = _completeUserDataProvider.loading;

    final _pageSize = MediaQuery.of(context).size.height;
    final _notifySize = MediaQuery.of(context).padding.top;
    final _appBarSize = AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: _pageSize - (_notifySize + _appBarSize),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TitleText("Selecciona tu foto de perfil."),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: _getImage,
                      child: CircleAvatar(
                        radius: 100,
                        child: Icon(
                          Icons.camera_alt,
                          size: 75,
                        ),
                        foregroundImage:
                            _avatar == null ? null : FileImage(_avatar),
                      ),
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            _avatar == null ? _skipAvatarUpload : _uploadAvatar,
                        child: Text("Continuar"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (loading) LoadingIndicator(),
        ],
      ),
    );
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      if (pickedFile != null) {
        _completeUserDataProvider.avatar = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _skipAvatarUpload() async {
    await _completeUserDataProvider.addUserToFirestore();
    Navigator.pop(context);
  }

  void _uploadAvatar() async {
    await _completeUserDataProvider.uploadAvatar();
    await _completeUserDataProvider.addUserToFirestore();
    Navigator.pop(context);
  }
}
