import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/screens/admin_home/admin_home.dart';
import 'package:water_metering_app/screens/customer_home/customer_home.dart';
import 'package:water_metering_app/screens/customer_home/user_not_verified.dart';
import 'package:water_metering_app/screens/meter_reader_home/meter_reader_home.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  _WebScreenLayoutState createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
  Widget build(BuildContext context) {
    MyUser? user = Provider.of<UserProvider>(context).getUser;
    if (user?.userType == 'admin') {
      return const AdminHome();
    } else if (user?.userType == 'meterReader') {
      return const MeterReaderHome();
    }
    if (user?.isVerified == false) {
      return const UserNotVerified();
    }
    return const CustomerHome();
  }
}
