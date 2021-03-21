import 'dart:html';

import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat/models/db_user.dart';
import 'package:flutter_firebase_chat/models/error_message.dart';

class CompleteUserDataProvider with ChangeNotifier {
  bool _uploadingAvatar = true;
  ErrorMessage _errorMessage;
  DBUser _dbUser;

  bool get uploadingAvatar => _uploadingAvatar;
  ErrorMessage get errorMessage => _errorMessage;
  DBUser get dbUser => _dbUser;

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

  Future<void> uploadAvatar(File avatar) {}
}
