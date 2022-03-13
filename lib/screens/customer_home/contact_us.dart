import 'package:flutter/material.dart';
import 'package:water_metering_app/screens/customer_home/create_complaint.dart';
import 'package:water_metering_app/widgets/drawer.dart';

class ContactUs extends StatelessWidget {
  static const String routeName = '/contact_us';
  const ContactUs({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Contact Us'),
      ),
      drawer: const AppDrawer(),
      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(50, 20, 50, 0),
            leading: Icon(Icons.phone_android, size: 40),
            title: Text("Mobile Number"),
            selectedTileColor: Colors.green[400],
            subtitle: Text('0912WATER34'),
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            leading: Icon(Icons.email, size: 40),
            title: Text("Email Address"),
            selectedTileColor: Colors.green[400],
            subtitle: Text('water_utility@gmail.com'),
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(50, 0, 50, 10),
            leading: Icon(Icons.phone, size: 40),
            title: Text("Telephone Number"),
            selectedTileColor: Colors.green[400],
            subtitle: Text('63-WATER123'),
          ),
          ListTile(
            title: const Text(
              'Is there an error in your bill?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
            subtitle: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton.icon(
                    label: Text('SUBMIT TICKET'),
                    icon: Icon(Icons.warning_rounded),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateComplaint(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
