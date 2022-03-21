import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/utils/utils.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/services/auth_methods.dart';
import 'package:water_metering_app/utils/constants.dart';

class EditUserData extends StatefulWidget {
  const EditUserData({Key? key}) : super(key: key);
  static const String routeName = '/updateProfile';

  @override
  _EditUserDataState createState() => _EditUserDataState();
}

class _EditUserDataState extends State<EditUserData> {

  @override
  Widget build(BuildContext context) {
    final MyUser user = Provider.of<UserProvider>(context).getUser;
    final CollectionReference userlist = FirebaseFirestore.instance.collection('users');

    String newEmail = 'placeholder', newPassword = 'placeholder',  newPasswordRetype = 'placeholder', newDisplayName = 'placeholder', newPhoneNumber = 'placeholder';

    Future<void> updateUserInfo(String param, String newValue) async {
      return await userlist.doc(user.uid).update({
        param : newValue,
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.teal,
      ),
      drawer: CustomerDrawer(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child:
              TextField(
                controller: TextEditingController(),
                decoration:
                  textInputDecoration.copyWith(hintText: 'Enter new email address...'),
                onChanged: (String value) {
                  newEmail = value;
                },
              ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right:20),
            child: TextButton(
              child: Text('SAVE CHANGES'),
              onPressed: () async {
                String result = await AuthMethods().updateEmail(newEmail);
                showSnackBar(result, context);
                updateUserInfo('email', newEmail);
              },
            ),
          ),
          const Divider(
            height: 10,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child:
            TextField(
              controller: TextEditingController(),
              decoration:
              textInputDecoration.copyWith(hintText: 'Enter new password...'),
              onChanged: (String value) {
                newPassword = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child:
            TextField(
              controller: TextEditingController(),
              decoration:
              textInputDecoration.copyWith(hintText: 'Re-enter new password...'),
              onChanged: (String value) {
                newPasswordRetype = value;
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right:20),
            child: TextButton(
              child: Text('SAVE CHANGES'),
              onPressed: () async {
                  String result = await AuthMethods().updatePassword(newPassword, newPasswordRetype);
                  showSnackBar(result, context);
              },
            ),
          ),
          const Divider(
            height: 10,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child:
            TextField(
              controller: TextEditingController(),
              decoration:
              textInputDecoration.copyWith(hintText: 'Enter new display name...'),
              onChanged: (String value) {
                newDisplayName = value;
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right:20),
            child: TextButton(
              child: Text('SAVE CHANGES'),
              onPressed: () async {
                updateUserInfo('displayName', newDisplayName);
                showSnackBar('Display name changed successfully.', context);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child:
            TextField(
              controller: TextEditingController(),
              decoration:
              textInputDecoration.copyWith(hintText: 'Enter new phone number...'),
              onChanged: (String value) {
                newPhoneNumber = value;
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right:20),
            child: TextButton(
              child: Text('SAVE CHANGES'),
              onPressed: () async {
                updateUserInfo('phoneNumber', newPhoneNumber);
                showSnackBar('Phone number changed successfully.', context);
              },
            ),
          ),
        ]
      )
    );
  }
}
