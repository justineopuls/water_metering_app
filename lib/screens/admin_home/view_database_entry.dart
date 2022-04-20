import 'package:flutter/material.dart';
import 'package:water_metering_app/screens/admin_home/view_customer_billing.dart';
import 'package:water_metering_app/screens/admin_home/view_customer_details.dart';
import 'package:water_metering_app/screens/admin_home/view_customer_records.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import 'billing_management.dart';

class ViewDatabaseEntry extends StatelessWidget {
  const ViewDatabaseEntry(
      {Key? key, required this.meterNumber, required this.uid})
      : super(key: key);
  static const String routeName = '/view_database_entry';
  final String meterNumber;
  final String uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal, title: Text('View details')),
      //drawer: const AdminDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          ListTile(
              title: Text("Account information"),
              subtitle: const Text(
                "View the listed account information.",
                style: TextStyle(
                  fontSize: 12.5,
                ),
              ),
              leading: Icon(Icons.person, size: 40),
              trailing: Icon(Icons.chevron_right, size: 30),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewCustomerDetails(uid: uid),
                    ));
              }),
          ListTile(
              title: Text("Records"),
              subtitle: const Text(
                "View the available records.",
                style: TextStyle(
                  fontSize: 12.5,
                ),
              ),
              leading: Icon(Icons.photo_album, size: 40),
              trailing: Icon(Icons.chevron_right, size: 30),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewCustomerRecords(meterNumber: meterNumber),
                    ));
              }),
          ListTile(
            title: Text("Billing"),
            subtitle: const Text(
              "View the available billing statements.",
              style: TextStyle(
                fontSize: 12.5,
              ),
            ),
            leading: Icon(Icons.list, size: 40),
            trailing: Icon(Icons.chevron_right, size: 30),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        //ViewCustomerBilling(meterNumber: meterNumber, uid: uid),
                        BillingManagement(meterNumber: meterNumber, uid: uid),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
