import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:water_metering_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';
import 'package:water_metering_app/routes/routes.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/screens/authenticate/sign_in.dart';
import 'package:water_metering_app/services/auth_methods.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);
  static const String routeName = '/customer_profile';

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  @override
  Widget build(BuildContext context) {
    //final MyUser? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text('Your Profile'),
      ),
      drawer: CustomerDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          ListTile(
            title: Text("Account information"),
            subtitle: const Text(
              "View or update your listed account information.",
              style: TextStyle(
                fontSize: 12.5,
              ),
            ),
            leading: Icon(Icons.person, size: 40),
            trailing: Icon(Icons.chevron_right, size: 30),
            onTap: () {
              Navigator.pushNamed(context, Routes.editProfile);
            },
          ),
          ListTile(
            title: Text("Change your password"),
            subtitle: const Text(
              "Update your password at any time.",
              style: TextStyle(
                fontSize: 12.5,
              ),
            ),
            leading: Icon(Icons.lock, size: 40),
            trailing: Icon(Icons.chevron_right, size: 30),
            onTap: () {
              Navigator.pushNamed(context, Routes.changePassword);
            },
          ),
        ],
      ),
    );
  }
}
