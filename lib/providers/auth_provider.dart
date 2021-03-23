import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/models/db_user.dart';
import 'package:flutter_firebase_chat/models/error_message.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  static const String USER_NOT_FOUND_ERROR = "user-not-found";
  static const String WRONG_PASSWORD_ERROR = "wrong-password";
  static const String WEAK_PASSWORD_ERROR = "weak-password";

  bool _loadingDBUserData = true;
  bool _userExists = false;
  FirebaseAuth _auth;
  User _firebaseUser;
  Status _status = Status.Uninitialized;
  ErrorMessage _errorMessage;
  DBUser _dbUser;

  AuthProvider.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  bool get userExists => _userExists;
  bool get loadingDBUserData => _loadingDBUserData;
  Status get status => _status;
  User get firebaseUser => _firebaseUser;
  FirebaseAuth get auth => _auth;
  ErrorMessage get errorMessage => _errorMessage;
  DBUser get dbUser => _dbUser;

  set userExists(bool value) {
    _userExists = value;
    notifyListeners();
  }

  set loadingDBUserData(bool value) {
    _loadingDBUserData = value;
    notifyListeners();
  }

  set status(Status value) {
    _status = value;
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

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      status = Status.Authenticating;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      errorMessage = ErrorMessage(error: false);
    } on FirebaseAuthException catch (e) {
      errorMessage =
          ErrorMessage(code: e.code, message: e.message, error: true);
      if (e.code == USER_NOT_FOUND_ERROR) {
        signUp(email, password);
      } else {
        status = Status.Unauthenticated;
      }
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      status = Status.Authenticating;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      errorMessage = ErrorMessage(error: false);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      status = Status.Unauthenticated;
      errorMessage =
          ErrorMessage(code: e.code, message: e.message, error: true);
    }
  }

  Future signOut() async {
    print('signOut');
    await _auth.signOut();
    status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(User value) async {
    print("_onAuthStateChanged");
    if (value == null) {
      _status = Status.Unauthenticated;
    } else {
      _firebaseUser = value;
      _status = Status.Authenticated;
      _listenToUserDataChanges();
    }
    print("firebaseUser == null: ${firebaseUser == null}");
    notifyListeners();
  }

  static String getCurrentUserUid() {
    return FirebaseAuth.instance.currentUser.uid;
  }

  static String getCurrentUserEmail() {
    return FirebaseAuth.instance.currentUser.email;
  }

  void _listenToUserDataChanges() {
    print("_listenToUserDataChanges");
    if (_firebaseUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .snapshots()
          .listen((documentSnapshot) {
        userExists = documentSnapshot.exists;
        if (userExists) {
          print("The user does exists in the db");
          dbUser = DBUser.fromJson(
            id: documentSnapshot.id,
            data: documentSnapshot.data(),
          );
        } else {
          print("The user doesnt exists in the db");
          dbUser = null;
        }
        loadingDBUserData = false;
      });
    }
  }

  Future<void> uploadAvatar(File avatar) async {
    loadingDBUserData = true;
    String userId = AuthProvider.getCurrentUserUid();
    String storagePath = 'users/$userId/avatar.jpg';
    Reference storageReference =
        FirebaseStorage.instance.ref().child(storagePath);
    UploadTask uploadTask = storageReference.putFile(avatar);
    TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);
    String avatarUrl = await downloadUrl.ref.getDownloadURL();
    dbUser.avatar = avatarUrl;

    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update(dbUser.toJson());

    loadingDBUserData = false;
    _updateUserDataInChats();
  }

  void changeUserName(String name, String lastName) {
    dbUser.name = name;
    dbUser.lastName = lastName;
    FirebaseFirestore.instance
        .collection("users")
        .doc(dbUser.id)
        .update(dbUser.toJson());
    _updateUserDataInChats();
  }

  void _updateUserDataInChats() {
    FirebaseFirestore.instance
        .collection("chats")
        .where("participants", arrayContains: dbUser.id)
        .get()
        .then((documents) {
      final batch = FirebaseFirestore.instance.batch();
      List<Chat> chats = documents.docs
          .map((e) => Chat.fromJson(id: e.id, data: e.data()))
          .toList();

      chats.forEach((chat) {
        // Array of usersData
        List<ParticipantsData> usersData = chat.participantsData;

        // We get the user data object
        ParticipantsData userData =
            usersData.where((element) => element.id == dbUser.id).first;

        // We remove the user data object from list
        usersData.removeWhere((element) => element.id == dbUser.id);

        // Update the user data
        userData.name = dbUser.name;
        userData.lastName = dbUser.lastName;
        userData.avatar = dbUser.avatar;

        // Add the update user data object to list
        usersData.add(userData);

        // Create the chat document reference
        final chatRef =
            FirebaseFirestore.instance.collection("chats").doc(chat.id);

        // Add update task to batch
        batch.update(chatRef, chat.toJson());
      });

      batch.commit();
    });
  }
}
