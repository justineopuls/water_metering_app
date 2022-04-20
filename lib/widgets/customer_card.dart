import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_metering_app/screens/admin_home/validate_customer_account_view.dart';
import 'package:water_metering_app/utils/colors.dart';

import '../screens/admin_home/complaint_view_page.dart';

class CustomerCard extends StatelessWidget {
  final snapshot;
  const CustomerCard({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String displayName = snapshot['displayName'];
    final String email = snapshot['email'];

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ValidateCustomerAccountPage(
                  snapshot: snapshot,
                ),
              ));
        },
        title: Text(displayName),
        subtitle: Text(email),
      ),
    );
  }
}
