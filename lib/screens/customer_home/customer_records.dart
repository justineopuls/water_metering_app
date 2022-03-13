import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';

class CustomerRecords extends StatelessWidget {
  const CustomerRecords({Key? key}) : super(key: key);

  static const String routeName = '/customer_records';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Records'),
      ),
      drawer: const CustomerDrawer(),
      body: Center(
        child: const Text('Customer Records Screen'),
      ),
    );
  }
}
