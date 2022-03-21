import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/utils/colors.dart';
import 'package:water_metering_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/widgets/textfield.dart';
import 'package:water_metering_app/services/storage_methods.dart';
import 'package:water_metering_app/widgets/edit_profile_button.dart';
import 'package:water_metering_app/screens/authenticate/sign_in.dart';
import 'package:water_metering_app/services/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_metering_app/services/firestore_methods.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  static const String routeName = '/edit_profile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  @override
  Widget build(BuildContext context) {
    //final MyUser user = Provider.of<UserProvider>(context).getUser;

    return StreamBuilder<UserData>(
      stream:
  }
}