import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:uuid/uuid.dart';
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
import 'package:water_metering_app/widgets/update_user_data.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  static const String routeName = '/edit_profile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Edit Profile'),
        ),
        drawer: CustomerDrawer(),
        body: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            CircleAvatar(
              radius: 50,
              child: ClipOval(
                  child: Icon(
                Icons.account_circle,
                size: 100,
              )),
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              label: 'Full Name',
              text: user!.displayName,
              onChanged: (name) {},
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              label: 'Email',
              text: user.email,
              onChanged: (email) {},
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              label: 'Phone Number',
              text: '09231234567',
              onChanged: (phoneNumber) {},
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              label: 'Address',
              text: '123 Village Yan Subd., Marikina, Philippines',
              onChanged: (address) {},
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text('SAVE'),
              ),
            ),
          ],
        ));
  }
}
