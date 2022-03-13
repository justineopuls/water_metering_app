import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';

class DatabaseChecking extends StatelessWidget {
  const DatabaseChecking({Key? key}) : super(key: key);

  static const String routeName = '/database_checking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Database Checking'),
      ),
      drawer: const AdminDrawer(),
      body: Center(
        child: const Text('Database Checking Screen'),
      ),
    );
  }
}
