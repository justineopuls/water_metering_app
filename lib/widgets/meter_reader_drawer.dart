import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/routes/routes.dart';
import 'package:water_metering_app/screens/authenticate/sign_in.dart';
import 'package:water_metering_app/services/auth_methods.dart';

class MeterReaderDrawer extends StatelessWidget {
  const MeterReaderDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<UserProvider>(context).getUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(user: user),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () =>
                Navigator.pushReplacementNamed(context, Routes.meterReaderHome),
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.cloud_upload,
            text: 'Upload',
            onTap: () => Navigator.pushReplacementNamed(
                context, Routes.meterReaderUpload),
          ),
          const Divider(),
          _createDrawerItem(
              icon: Icons.logout,
              text: 'Sign Out',
              onTap: () async {
                await AuthMethods().signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SignIn(),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _createHeader({required MyUser? user}) {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.teal,
      ),
      accountName: Text(user!.displayName),
      accountEmail: Text(user.email),
      currentAccountPicture: const CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.person, color: Colors.white, size: 60),
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
