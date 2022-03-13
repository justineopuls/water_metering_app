import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';

class PhotoUpload extends StatelessWidget {
  const PhotoUpload({Key? key}) : super(key: key);

  static const String routeName = '/photo_upload';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Photo Upload'),
      ),
      drawer: const AdminDrawer(),
      body: Center(
        child: const Text('Photo Upload Screen'),
      ),
    );
  }
}
