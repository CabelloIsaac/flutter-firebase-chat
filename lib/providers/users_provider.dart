import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat/models/db_user.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';

class UsersProvider with ChangeNotifier {
  List<DBUser> _users = [];
  DBUser _user;
  bool _isListening = false;

  List<DBUser> get users => _users;
  DBUser get user => _user;

  set users(List<DBUser> value) {
    _users = value;
    notifyListeners();
  }

  set user(DBUser value) {
    _user = value;
    notifyListeners();
  }

  void loadUsers() {
    if (!_isListening) {
      FirebaseFirestore.instance
          .collection("users")
          .orderBy("name")
          .snapshots()
          .listen((documents) {
        users = documents.docs
            .map((e) => DBUser.fromJson(id: e.id, data: e.data()))
            .toList();
      });
      _isListening = true;
    }
  }
}
