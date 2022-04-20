import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/utils/constants.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';

class DeleteAccount extends StatefulWidget {
  static const String routeName = '/delete_account';

  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Search for a user',
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      drawer: const AdminDrawer(),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'displayName',
                    isGreaterThanOrEqualTo: searchController.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Loading();
                }

                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text((snapshot.data! as dynamic).docs[index]
                          ['displayName']),
                    );
                  },
                );
              },
            )
          : Text('Test'),
    );
  }
}
