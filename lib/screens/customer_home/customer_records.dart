import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';
import 'package:water_metering_app/services/storage_methods.dart';

class FirebaseDownload {
  FirebaseStorage storage = FirebaseStorage.instance;
}

class CustomerRecords extends StatelessWidget {
  const CustomerRecords({Key? key}) : super(key: key);

  static const String routeName = '/customer_records';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Records'),
      ),
      drawer: const CustomerDrawer(),
      body: Center(
        child: TextButton(
          child: Text('Download'),
          onPressed: (){
            loadImage();
          },
        ),
      ),
    );
  }
}

Future <String> loadImage() async{
  //current user id
  final _userID = FirebaseAuth.instance.currentUser!.uid;

  //collect the image name
  DocumentSnapshot variable = await FirebaseFirestore.instance.
  collection('users').
  doc(_userID).
  //collection('records').
  get();

  //a list of images names (i need only one)
  var _file_name = variable['records'];

  //select the image url
  Reference  ref = FirebaseStorage.instance.ref().child('test_records').child(_file_name[0]);

  //get image url from firebase storage
  var url = await ref.getDownloadURL();
  print('url: ' + url);
  return url;
}