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
import 'package:water_metering_app/services/storage_methods.dart';
import 'package:water_metering_app/screens/authenticate/sign_in.dart';
import 'package:water_metering_app/services/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_metering_app/services/firestore_methods.dart';

import '../../routes/routes.dart';


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
    final String? uid = user?.uid;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: Text('Account Information'),
              ),
              drawer: CustomerDrawer(),
              body: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  ListTile(
                    title: Text("Account Name",style: TextStyle(fontWeight: FontWeight.w500),),
                    subtitle: Text(snapshot.data.data()['displayName']),
                    trailing: Icon(Icons.chevron_right, size: 30),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.changeUsername);
                    },
                  ),
                  ListTile(
                    title: Text("Mobile Number",style: TextStyle(fontWeight: FontWeight.w500),),
                    subtitle: Text(snapshot.data.data()['phoneNumber']),
                    trailing: Icon(Icons.chevron_right, size: 30),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.changeNumber);
                    },
                  ),
                  ListTile(
                    title: Text("Email",style: TextStyle(fontWeight: FontWeight.w500),),
                    subtitle: Text(snapshot.data.data()['email']),
                    trailing: Icon(Icons.chevron_right, size: 30),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.changeEmail);
                    },
                  ),
                ],
              )
           );
          }
        }
      );
    }
}