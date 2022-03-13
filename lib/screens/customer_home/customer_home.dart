import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/drawer.dart';

class CustomerHome extends StatelessWidget {
  const CustomerHome({Key? key}) : super(key: key);

  static const String routeName = '/customer_home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Home'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: const Text('Customer Home Screen'),
      ),
    );
  }
}
