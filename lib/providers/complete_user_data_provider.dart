import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat/models/db_user.dart';
import 'package:flutter_firebase_chat/models/error_message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';

class CompleteUserDataProvider with ChangeNotifier {
  bool _loading = false;
  ErrorMessage _errorMessage;
  DBUser _dbUser;
  File _avatar;

  bool get loading => _loading;
  ErrorMessage get errorMessage => _errorMessage;
  DBUser get dbUser => _dbUser;
  File get avatar => _avatar;

  set loading(bool value) {
    _loading = value;
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
    loading = true;
    String userId = AuthProvider.getCurrentUserUid();
    String storagePath = 'users/$userId/avatar.jpg';

    Reference storageReference =
        FirebaseStorage.instance.ref().child(storagePath);
    UploadTask uploadTask = storageReference.putFile(avatar);
    TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);
    String avatarUrl = await downloadUrl.ref.getDownloadURL();

    dbUser.avatar = avatarUrl;
    loading = false;
  }

  Future<void> addUserToFirestore() async {
    loading = true;
    String userId = AuthProvider.getCurrentUserUid();
    String userEmail = AuthProvider.getCurrentUserEmail();

    dbUser.email = userEmail;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(dbUser.toJson());
    loading = false;
  }
}
