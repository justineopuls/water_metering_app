import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';

class ComplaintHandling extends StatelessWidget {
  const ComplaintHandling({Key? key}) : super(key: key);

  static const String routeName = '/complaint_handling';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Complaint Handling'),
      ),
      drawer: const AdminDrawer(),
      body: Center(
        child: const Text('Complaint Handling Screen'),
      ),
    );
  }
}
