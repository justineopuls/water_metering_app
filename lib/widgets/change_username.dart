import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/utils/utils.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/services/auth_methods.dart';
import 'package:water_metering_app/utils/constants.dart';
import 'package:water_metering_app/routes/routes.dart';

class ChangeUsername extends StatefulWidget {
  const ChangeUsername({Key? key}) : super(key: key);

  static const String routeName = '/change_username';
  @override
  _ChangeUsernameState createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<UserProvider>(context).getUser;
    final CollectionReference userList = FirebaseFirestore.instance.collection('users');
    final String? uid = user?.uid;
    String newDisplayName = 'placeholder';

    Future<void> updateUserInfo(String param, String newValue) async {
      return await userList.doc(uid).update({
        param : newValue,
      });
    }
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Edit Account Name'),
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
                      textInputDecoration.copyWith(
                          hintText: 'Enter new name...'),
                      onChanged: (String value) {
                        newDisplayName = value;
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(right: 20),
                    child: TextButton(
                      child: Text('SAVE CHANGES'),
                      onPressed: () async {
                        if (newDisplayName == 'placeholder') {
                          showSnackBar('Error in setting name.', context);
                          updateUserInfo('displayName', snapshot.data.data()['displayName']);
                        } else {
                          updateUserInfo('displayName', newDisplayName);
                          showSnackBar('Display name changed successfully.', context);
                        }
                      },
                    ),
                  ),
                ], // ListView Children
              ),
            );
          }
        }
      );
  }
}
