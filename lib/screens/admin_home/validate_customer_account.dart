import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';
import 'package:water_metering_app/widgets/customer_card.dart';

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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('isVerified', isEqualTo: false)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => CustomerCard(
                  snapshot: snapshot.data!.docs[index].data(),
                ),
              );
            }
          },
        ));
  }
}
