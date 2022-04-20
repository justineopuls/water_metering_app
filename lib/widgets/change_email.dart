import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/utils/utils.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/services/auth_methods.dart';
import 'package:water_metering_app/utils/constants.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);
  static const String routeName = '/change_email';
  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<UserProvider>(context).getUser;
    final CollectionReference userList =
        FirebaseFirestore.instance.collection('users');
    String? currentUid = user?.uid;
    String newEmail = 'placeholder';

    Future<void> updateUserInfo(String param, String newValue) async {
      return await userList.doc(currentUid).update({
        param: newValue,
      });
    }

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
                title: Text('Edit Account Email'),
                backgroundColor: Colors.teal,
              ),
              body: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: TextEditingController(),
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Enter new email...'),
                      onChanged: (String value) {
                        newEmail = value;
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(right: 20),
                    child: TextButton(
                      child: Text('SAVE CHANGES'),
                      onPressed: () async {
                        String result =
                            await AuthMethods().updateEmail(newEmail);
                        showSnackBar(result, context);
                        if (result == "Successfully changed email") {
                          updateUserInfo('email', newEmail);
                        }
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
