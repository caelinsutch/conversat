import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> get getUser => _auth.currentUser();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  /// Sign in with Google oAuth
  ///
  /// Returns [Future] true if the user is new
  /// Return [Future] false if the user is new
  /// Return [Future] null if the an error occurs (i.e. user doesn't exist)
  Future<bool> googleSignIn() async {
    try {
      // Account
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      // Auth
      GoogleSignInAuthentication googleAuth =
      await googleSignInAccount.authentication;
      // Credential for firebase
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken);
      // Get user from Db
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      updateUserData(user);
      DocumentReference userRef = _db.collection('users').document(user.uid);
      DocumentSnapshot doc = await userRef.get();
      if (doc.exists) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  /// Update the user database with information from the Firebase user
  Future<void> updateUserData(FirebaseUser user) {
    DocumentReference userRef = _db.collection('users').document(user.uid);

    return userRef.setData({
      'uid': user.uid,
      'displayName': user.displayName,
      'email': user.email,
    }, merge: true);
  }

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }
}