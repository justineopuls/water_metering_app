import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/utils/utils.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/services/auth_methods.dart';
import 'package:water_metering_app/utils/constants.dart';

class ChangeNumber extends StatefulWidget {
  const ChangeNumber({Key? key}) : super(key: key);
  static const String routeName = '/change_number';
  @override
  _ChangeNumberState createState() => _ChangeNumberState();
}

class _ChangeNumberState extends State<ChangeNumber> {
  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<UserProvider>(context).getUser;
    final CollectionReference userList = FirebaseFirestore.instance.collection('users');
    final String? uid = user?.uid;
    String newPhoneNumber = 'placeholder';

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
                title: Text('Edit Phone Number'),
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
                          hintText: 'Enter new phone number...'),
                      onChanged: (String value) {
                        newPhoneNumber = value;
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(right: 20),
                    child: TextButton(
                      child: Text('SAVE CHANGES'),
                      onPressed: () async {
                        if (newPhoneNumber == 'placeholder') {
                          showSnackBar('Error in setting number.', context);
                          updateUserInfo('phoneNumber', snapshot.data.data()['phoneNumber']);
                        } else {
                          updateUserInfo('phoneNumber', newPhoneNumber);
                          showSnackBar('Phone number changed successfully.', context);
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
