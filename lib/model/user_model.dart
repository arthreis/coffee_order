import 'dart:developer';

import 'package:coffee_order/api/api.dart';
import 'package:coffee_order/dto/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserModel with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  FirebaseUser _user;
  User _userDto;
  bool _loading = false;
  bool _error = false;

  FirebaseUser get user => _user;

  bool get loading => _loading;
  set loading(value) {
    _loading = value;
    notifyListeners();
  }

  bool get error => _error;

  User get userDto {
    return _userDto;
  }

  UserModel() {
    getLoggedUser();
  }

  void getLoggedUser() async {
    _user = await _firebaseAuth.currentUser();
    _userDto = User.fromFirebaseUser(user);
    notifyListeners();
  }

  void loginOrSignUp(context) async {
    _error = false;
    loading = true;
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      _user = (await _firebaseAuth.signInWithCredential(credential)).user;
      _userDto = await Api().getUserByEmail(_user.email);
      if (_userDto == null) {
        _userDto = await Api().createUser(User.fromFirebaseUser(_user));
      }
    } catch (err, stacktrace) {
      log(err.toString(), stackTrace: stacktrace);
      _error = true;
    } finally {
      loading = false;
    }
  }

  void logout() async {
    final googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      googleSignIn.signOut();
    }
    _firebaseAuth.signOut();
    _user = await _firebaseAuth.currentUser();
    _userDto = User.fromFirebaseUser(_user);
    notifyListeners();
  }
}