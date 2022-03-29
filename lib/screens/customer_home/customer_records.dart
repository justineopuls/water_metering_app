import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';
import 'package:water_metering_app/widgets/reading_card.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/providers/user_provider.dart';

class CustomerRecords extends StatefulWidget {
  const CustomerRecords({Key? key}) : super(key: key);
  static const String routeName = '/customer_records';
  @override
  _CustomerRecordsState createState() => _CustomerRecordsState();
}

class _CustomerRecordsState extends State<CustomerRecords> {
  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<UserProvider>(context).getUser;
    final String? meterNumber = user?.meterNumber;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Records'),
        ),
        drawer: const CustomerDrawer(),
        body: StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection('admin_uploads').doc(meterNumber).collection('readings').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
