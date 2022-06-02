import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:water_metering_app/services/firestore_methods.dart';
import 'package:water_metering_app/utils/utils.dart';

class RecordsViewPage extends StatelessWidget {
  final snapshot;
  const RecordsViewPage({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.topLeft,
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              height: 200,
              child: ClipRect(
                child: PhotoView(
                  imageProvider: snapshot['photoUrl'] == ''
                      ? const NetworkImage(
                          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")
                      : NetworkImage(snapshot['photoUrl']),
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  initialScale: PhotoViewComputedScale.covered,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Meter Number:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(snapshot['meterNumber']),
            ),
            ListTile(
              title: const Text(
                "Date Uploaded:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(DateFormat.yMMMd()
                  .format(snapshot['datePublished'].toDate())),
            ),
            ListTile(
              title: const Text(
                "Date Image Taken:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(snapshot['photoDateTime']),
            ),
            ListTile(
              title: const Text(
                "Image Taken at:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(snapshot['photoLocation']),
            ),
          ],
        ),
      ),
    );
  }
}
