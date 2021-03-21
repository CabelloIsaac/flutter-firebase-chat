import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
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
          dbUser = DBUser.fromJson(documentSnapshot.data());
        } else {
          print("The user doesnt exists in the db");
          dbUser = null;
        }
        loadingDBUserData = false;
      });
    }
  }
}
