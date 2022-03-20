import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';
import 'package:water_metering_app/widgets/complaint_card.dart';

class ComplaintHandling extends StatelessWidget {
  const ComplaintHandling({Key? key}) : super(key: key);

  static const String routeName = '/complaint_handling';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Complaint Handling'),
        ),
        drawer: const AdminDrawer(),
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('complaints').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => ComplaintCard(
                  snapshot: snapshot.data!.docs[index].data(),
                ),
              );
            }
          },
        ));
  }
}
