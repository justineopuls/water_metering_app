import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/screens/admin_home/admin_home.dart';
import 'package:water_metering_app/screens/customer_home/contact_us.dart';
import 'package:water_metering_app/screens/customer_home/customer_home.dart';
import 'package:water_metering_app/services/auth_methods.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  _WebScreenLayoutState createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
  Widget build(BuildContext context) {
    MyUser? user = Provider.of<UserProvider>(context).getUser;
    print(user?.userType);
    if (user?.userType == 'admin') {
      return AdminHome();
    } else
      return CustomerHome();
  }
}

