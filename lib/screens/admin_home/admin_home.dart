import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';


class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  static const String routeName = '/admin_home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Home'),
      ),
      drawer: const AdminDrawer(),
      body: Center(
        child: const Text('Admin Home Screen'),
      ),
    );
  }
}
