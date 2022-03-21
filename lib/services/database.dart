import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/services/auth_methods.dart';

class DatabaseMethods {
  final String uid;
  DatabaseMethods({this.uid});
  //final MyUser user = Provider.of<UserProvider>(context).getUser;
  final CollectionReference userList = FirebaseFirestore.instance.collection('users');

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      displayName: snapshot['displayName'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      meterNumber: snapshot['meterNumber'],
      userType: snapshot['userType'],
    );
  }

  Stream<UserData> get userData {
    return userList.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}