import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_metering_app/screens/admin_home/view_database_entry.dart';
import 'package:water_metering_app/utils/colors.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class MeterNumberCard extends StatelessWidget {
  const MeterNumberCard({Key? key, required this.snapshot}) : super(key: key);
  final snapshot;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => ViewDatabaseEntry(meterNumber: snapshot['meterNumber'], uid: snapshot['uid']),
            )
            );
          },
          child:
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text('Meter Number: ' + snapshot['meterNumber'])
                  ],
                ),
              )
            ),
        ),
    );
  }
}