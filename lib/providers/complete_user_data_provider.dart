import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat/models/db_user.dart';
import 'package:flutter_firebase_chat/models/error_message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';

class CompleteUserDataProvider with ChangeNotifier {
  bool _uploadingAvatar = false;
  ErrorMessage _errorMessage;
  DBUser _dbUser;
  File _avatar;

  bool get uploadingAvatar => _uploadingAvatar;
  ErrorMessage get errorMessage => _errorMessage;
  DBUser get dbUser => _dbUser;
  File get avatar => _avatar;

  set uploadingAvatar(bool value) {
    _uploadingAvatar = value;
    notifyListeners();
  }

  set errorMessage(ErrorMessage value) {
    _errorMessage = value;
    notifyListeners();
  }

  set dbUser(DBUser value) {
    _dbUser = value;
    notifyListeners();
  }

  set avatar(File value) {
    _avatar = value;
    notifyListeners();
  }

  Future<void> uploadAvatar() async {
    uploadingAvatar = true;
    String userId = AuthProvider.getCurrentUserUid();
    String storagePath = 'users/$userId/avatar.jpg';

    Reference storageReference =
        FirebaseStorage.instance.ref().child(storagePath);
    UploadTask uploadTask = storageReference.putFile(avatar);
    TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);
    String avatarUrl = await downloadUrl.ref.getDownloadURL();

    dbUser.avatar = avatarUrl;
    uploadingAvatar = false;
  }

  Future<void> addUserToFirestore() async {
    uploadingAvatar = true;
    String userId = AuthProvider.getCurrentUserUid();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(dbUser.toJson());
    uploadingAvatar = false;
  }
}
