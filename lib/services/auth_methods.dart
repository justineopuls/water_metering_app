import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/models/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<MyUser> getUserData() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return MyUser.fromSnapshot(snapshot);
  }

  // Sign Up User
  Future<String> signUpUser({
    required String email,
    required String password,
    required String displayName,
    required String meterNumber,
  }) async {
    String result = 'Some error occured.';
    try {
      // Register User
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Add user to database

      MyUser user = MyUser(
        displayName: displayName,
        uid: userCredential.user!.uid,
        email: email,
        meterNumber: meterNumber,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set(
            user.toJson(),
          );

      result = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        result =
            'The password provided is too weak. Please enter a password with 6+ characters.';
      } else if (e.code == 'email-already-in-use') {
        result = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        result = 'The email is badly formatted. Please enter a valid email.';
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  // Logging In User
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String result = 'Some error occured.';
    try {
      // Log In User
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      result = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        result = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        result = 'The email is badly formatted. Please enter a valid email.';
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  // Sign Out User
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
