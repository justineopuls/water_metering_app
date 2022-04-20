import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';
import 'package:water_metering_app/widgets/reading_card.dart';

class ViewCustomerRecords extends StatefulWidget {
  const ViewCustomerRecords({Key? key, required this.meterNumber})
      : super(key: key);
  static const String routeName = '/view_customer_records';
  final meterNumber;
  @override
  _ViewCustomerRecordsState createState() => _ViewCustomerRecordsState();
}

class _ViewCustomerRecordsState extends State<ViewCustomerRecords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Records'),
        ),
        //drawer: const AdminDrawer(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('admin_uploads')
              .doc(widget.meterNumber)
              .collection('readings')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => ReadingCard(
                  snapshot: snapshot.data!.docs[index].data(),
                ),
              );
            }
          },
        ));
  }
}
