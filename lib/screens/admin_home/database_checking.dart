import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:water_metering_app/widgets/meter_number_card.dart';

import '../../widgets/reading_card.dart';

class DatabaseChecking extends StatefulWidget {
  const DatabaseChecking({Key? key}) : super(key: key);
  static const String routeName = '/database_checking';

  @override
  _DatabaseCheckingState createState() => _DatabaseCheckingState();
}

class _DatabaseCheckingState extends State<DatabaseChecking> {
  String? searchValue;
  Widget customSearchBar = const Text('Database Checking');
  Widget customBody = StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('userType', isEqualTo: 'customer')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) => MeterNumberCard(
              snapshot: snapshot.data!.docs[index].data(),
            ),
          );
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: customSearchBar,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                customSearchBar = TextField(
                  decoration: const InputDecoration(
                    hintText: 'search for meter number...',
                    //
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (value) {
                    searchValue = value;
                    customBody = StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('meterNumber', isEqualTo: searchValue)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Loading();
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) =>
                                    MeterNumberCard(
                                        snapshot:
                                            snapshot.data!.docs[index].data()));
                          }
                        });
                  },
                );
              });
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: const AdminDrawer(),
      body: Column(
        children: [
          customBody
          // StreamBuilder(
          //   stream: FirebaseFirestore.instance.collection('users').where('userType', isEqualTo: 'customer').snapshots(),
          //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Loading();
          //     } else {
          //       return ListView.builder(
          //           shrinkWrap: true,
          //           itemCount: snapshot.data?.docs.length,
          //           itemBuilder: (context, index) => MeterNumberCard(
          //               snapshot: snapshot.data!.docs[index].data())
          //       );
          //       }
          //     }
          // )
        ],
      ),
    );
  }
}
