import 'package:flutter/material.dart';
import 'package:water_metering_app/screens/admin_home/upload_billing_statement.dart';
import 'package:water_metering_app/screens/admin_home/view_customer_billing.dart';
import 'package:water_metering_app/screens/admin_home/view_customer_details.dart';
import 'package:water_metering_app/screens/admin_home/view_customer_records.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class BillingManagement extends StatelessWidget {
  const BillingManagement({Key? key, required this.meterNumber, required this.uid}) : super(key: key);
  static const String routeName = '/view_database_entry';
  final String meterNumber;
  final String uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Billing')
      ),
      drawer: const AdminDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          ListTile(
            title: Text("Download"),
            subtitle: const Text("View the available billing statements.", style: TextStyle(
              fontSize: 12.5,),),
            leading: Icon(Icons.download, size:40),
            trailing: Icon(Icons.chevron_right, size: 30),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewCustomerBilling(meterNumber: meterNumber, uid: uid),
                  )
              );
            },
          ),
          ListTile(
            title: Text("Upload"),
            subtitle: const Text("Upload customer billing statements.", style: TextStyle(
              fontSize: 12.5,),),
            leading: Icon(Icons.upload, size:40),
            trailing: Icon(Icons.chevron_right, size: 30),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadBillingStatement(meterNumber: meterNumber, uid: uid),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
