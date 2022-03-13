import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/drawer.dart';

class CustomerBilling extends StatelessWidget {
  const CustomerBilling({Key? key}) : super(key: key);

  static const String routeName = '/customer_billing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Billing'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: const Text('Customer Billing Screen'),
      ),
    );
  }
}
