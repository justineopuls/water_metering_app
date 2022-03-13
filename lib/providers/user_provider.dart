import 'package:flutter/material.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/services/auth_methods.dart';

class UserProvider with ChangeNotifier {
  MyUser? _user;
  final AuthMethods _authMethods = AuthMethods();

  MyUser get getUser => _user!;

  Future<void> refreshUser() async {
    MyUser user = await _authMethods.getUserData();
    _user = user;
    notifyListeners();
  }
}
