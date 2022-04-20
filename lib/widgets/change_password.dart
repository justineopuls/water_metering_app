import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/utils/utils.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/services/auth_methods.dart';
import 'package:water_metering_app/routes/routes.dart';
import 'package:water_metering_app/utils/constants.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  static const String routeName = '/change_password';
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<UserProvider>(context).getUser;
    final String? currentUid = user?.uid;
    String newPassword = 'placeholder', newPasswordRetype = 'placeholder';

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUid)
            .snapshots(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Change Password'),
                backgroundColor: Colors.teal,
              ),
              body: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: TextEditingController(),
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Enter new password...'),
                      onChanged: (String value) {
                        newPassword = value;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: TextEditingController(),
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Re-enter new password...'),
                      onChanged: (String value) {
                        newPasswordRetype = value;
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(right: 20),
                    child: TextButton(
                      child: Text('SAVE CHANGES'),
                      onPressed: () async {
                        String result = await AuthMethods()
                            .updatePassword(newPassword, newPasswordRetype);
                        showSnackBar(result, context);
                      },
                    ),
                  ),
                ], // ListView Children
              ),
            );
          }
        });
  }
}
