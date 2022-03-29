import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';

class ValidateCustomerAccount extends StatelessWidget {
  const ValidateCustomerAccount({Key? key}) : super(key: key);

  static const String routeName = '/validate_customer_account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Validate Customer Account'),
      ),
      drawer: const AdminDrawer(),
      body: Center(
        child: const Text('Validate Customer Account Screen'),
      ),
    );
  }
}
