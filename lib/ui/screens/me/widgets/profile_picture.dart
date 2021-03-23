import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';
import 'package:flutter_firebase_chat/ui/screens/image_detail/image_detail_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  AuthProvider _authProvider;
  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    String avatar = _authProvider.dbUser.avatar;
    bool loading = _authProvider.loadingDBUserData;
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Stack(
        children: [
          Hero(
            tag: avatar,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ImageDetailScreen.route,
                    arguments: avatar);
              },
              child: CircleAvatar(
                radius: 55,
                child: loading
                    ? CircularProgressIndicator()
                    : avatar == null
                        ? Icon(
                            Icons.person,
                            size: 50,
                          )
                        : Container(),
                backgroundImage: avatar == null ? null : NetworkImage(avatar),
              ),
            ),
          ),
          GalleryPictureSelector(),
        ],
      ),
    );
  }
}

class GalleryPictureSelector extends StatefulWidget {
  const GalleryPictureSelector({
    Key key,
  }) : super(key: key);

  @override
  _GalleryPictureSelectorState createState() => _GalleryPictureSelectorState();
}

class _GalleryPictureSelectorState extends State<GalleryPictureSelector> {
  final picker = ImagePicker();

  AuthProvider _authProvider;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onTap: _getImage,
        child: Container(
          padding: EdgeInsets.all(9),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            color: Color.fromRGBO(229, 229, 229, 1.0),
            borderRadius: BorderRadius.circular(
              50.0,
            ),
          ),
          child: Icon(
            Icons.camera_alt,
            size: 25.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Future _getImage() async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        title: Text("Cambiar foto de perfil"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 24),
              title: Text('Seleccionar de la galería'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 24),
              title: Text('Tomar una foto'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );
    if (imageSource != null) {
      final pickedFile = await picker.getImage(
        source: imageSource,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        _authProvider.uploadAvatar(File(pickedFile.path));
      }
    }
  }
}
