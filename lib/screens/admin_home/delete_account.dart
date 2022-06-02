import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:water_metering_app/widgets/accounts_for_deletion.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  static const String routeName = '/delete_user_account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Accounts to Delete'),
        ),
        drawer: const AdminDrawer(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('isForDeletion', isEqualTo: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => AccountsForDeletion(
                  snapshot: snapshot.data!.docs[index].data(),
                ),
              );
            }
          },
        ));
  }
}
