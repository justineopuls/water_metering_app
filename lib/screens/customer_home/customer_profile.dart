import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:water_metering_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/widgets/edit_profile_button.dart';
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
    final MyUser? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0,
          title: const Text('Profile'),
        ),
        drawer: CustomerDrawer(),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(30, 25, 10, 10),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                        child: Icon(
                      Icons.account_circle,
                      size: 100,
                    )),
                  ),
                  Spacer(flex: 20),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user!.displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      EditProfileButton(
                        function: () {},
                      ),
                    ],
                  ),
                  Spacer(flex: 40),
                ],
              ),
            ),
            SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: 350,
                  height: 50,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          height: 2,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: 350,
                  height: 50,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '09231234567',
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          height: 2,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: 350,
                  height: 50,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '123 Village Yan Subd., Marikina, Philippines',
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          height: 2,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
