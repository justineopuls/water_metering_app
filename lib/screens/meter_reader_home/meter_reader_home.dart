import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/meter_reader_drawer.dart';

class MeterReaderHome extends StatelessWidget {
  const MeterReaderHome({Key? key}) : super(key: key);

  static const String routeName = '/meter_reader_home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Home'),
      ),
      drawer: const MeterReaderDrawer(),
      body: Center(
        child: const Text('Meter Reader Home Screen'),
      ),
    );
  }
}
