import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';

class CustomerBilling extends StatefulWidget {
  const CustomerBilling({Key? key}) : super(key: key);
  static const String routeName = '/customer_billing';

  @override
  _CustomerBillingState createState() => _CustomerBillingState();
}

class _CustomerBillingState extends State<CustomerBilling> {
  final items =  ['November 2021','December 2021','January 2022','February 2022','March 2022'];
  final Widget? hint = const Text('Please choose billing date...', style: TextStyle(fontStyle: FontStyle.italic));
  String? value;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.teal,
      title: Text('Billing'),
    ),
    drawer: CustomerDrawer(),
    body: ListView(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
          width: 350,
          padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45, width:2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: hint,
              disabledHint: hint,
              value: value,
              iconSize: 36,
              icon: Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              items:items.map(buildMenuItem).toList(),
              onChanged: (value) => setState(() => this.value = value),
            ),
          ),
        ),
        Container(
          padding:  EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          margin: EdgeInsets.fromLTRB(70,0,70,0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45, width:1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextButton(
            child: Text('DOWNLOAD BILLING STATEMENT'),
            onPressed: () {},
          ),
        )
      ],
    ),
  );
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item,
      style: TextStyle(
          fontSize: 15
      ),
    ),
  );
}