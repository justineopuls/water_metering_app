import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:water_metering_app/services/firestore_methods.dart';
import 'package:water_metering_app/utils/utils.dart';

class ComplaintViewPage extends StatelessWidget {
  final snapshot;
  const ComplaintViewPage({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    print('Here');
    FirebaseFirestore.instance
        .collection('complaints')
        .where('isResolved', isEqualTo: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print(doc["complaintId"]);
      }
    });

    markComplaintResolved() async {
      String result = await FirestoreMethods()
          .markComplaintAsResolved(snapshot['complaintId']);

      if (result == 'success') {
        Navigator.pop(context);
        showSnackBar('Marked complaint as resolved!', context);
      } else {
        Navigator.pop(context);
        showSnackBar(result, context);
      }
    }

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
                "Complaint Issued by:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(snapshot['displayName']),
            ),
            ListTile(
              title: const Text(
                "Complaint Description:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(snapshot['description']),
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
                "Date Issued:",
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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: const Text('Mark Complaint as Resolved'),
                onPressed: markComplaintResolved),
          ],
        ),
      ),
    );
  }
}
