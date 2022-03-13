import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/screens/customer_home/contact_us.dart';
import 'package:water_metering_app/screens/customer_home/customer_home.dart';
import 'package:water_metering_app/services/auth_methods.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    // MyUser user = Provider.of<UserProvider>(context).getUser;
    return CustomerHome();
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.teal,
    //     centerTitle: true,
    //     title: const Text("Home Page"),
    //   ),
    //   body: const Center(
    //     child: Text('Home page!'),
    //   ),
    //   drawer: Drawer(
    //     child: ListView(
    //       padding: EdgeInsets.zero,
    //       children: [
    //         UserAccountsDrawerHeader(
    //           decoration: BoxDecoration(
    //             color: Colors.teal,
    //           ),
    //           accountName: Text(user.displayName),
    //           accountEmail: Text(user.email),
    //           currentAccountPicture: CircleAvatar(
    //             backgroundColor: Colors.grey,
    //             child: Icon(Icons.person, color: Colors.white, size: 60),
    //           ),
    //         ),
    //         ListTile(
    //           leading: const Icon(Icons.article),
    //           title: const Text('Records'),
    //           onTap: () {
    //             // Update the state of the app
    //             // ...
    //             // Then close the drawer
    //             Navigator.pop(context);
    //           },
    //         ),
    //         ListTile(
    //           leading: const Icon(Icons.credit_card),
    //           title: const Text('Account Billing'),
    //           onTap: () {
    //             // Update the state of the app
    //             // ...
    //             // Then close the drawer
    //             Navigator.pop(context);
    //           },
    //         ),
    //         ListTile(
    //           leading: const Icon(Icons.message),
    //           title: const Text('Contact Us'),
    //           onTap: () {
    //             // Update the state of the app
    //             // ...
    //             // Then close the drawer
    //             Navigator.pop(context);
    //           },
    //         ),
    //         ListTile(
    //           leading: const Icon(Icons.logout),
    //           title: const Text('Sign Out'),
    //           onTap: () async {
    //             await AuthMethods().signOut();
    //             // Update the state of the app
    //             // ...
    //             // Then close the drawer
    //             Navigator.pop(context);
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
