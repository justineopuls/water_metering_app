import 'package:flutter/material.dart';
import 'package:water_metering_app/services/firestore_methods.dart';
import 'package:water_metering_app/utils/utils.dart';

class ValidateCustomerAccountPage extends StatelessWidget {
  final snapshot;
  const ValidateCustomerAccountPage({Key? key, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    verifyUserAccount() async {
      String result =
          await FirestoreMethods().verifyUserAccount(snapshot['uid']);

      if (result == 'success') {
        Navigator.pop(context);
        showSnackBar('User verified!', context);
      } else {
        Navigator.pop(context);
        showSnackBar(result, context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.topLeft,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text(
                "Customer Name:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(snapshot['displayName']),
            ),
            ListTile(
              title: const Text(
                "Email address:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(snapshot['email']),
            ),
            ListTile(
              title: const Text(
                "Meter Number:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(snapshot['meterNumber']),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: const Text('Verify User'),
                onPressed: verifyUserAccount),
          ],
        ),
      ),
    );
  }
}
