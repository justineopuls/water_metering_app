import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/customer_drawer.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class CustomerBilling extends StatefulWidget {
  const CustomerBilling({Key? key}) : super(key: key);
  static const String routeName = '/customer_billing';

  @override
  _CustomerBillingState createState() => _CustomerBillingState();
}

class _CustomerBillingState extends State<CustomerBilling> {
  //final items =  ['November 2021','December 2021','January 2022','February 2022','March 2022'];

  final Widget? hint = const Text('Please choose billing date...',
      style: TextStyle(fontStyle: FontStyle.italic));
  String? value;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider
        .of<UserProvider>(context)
        .getUser;
    final String? meterNumber = user?.meterNumber;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Billing'),
      ),
      drawer: CustomerDrawer(),
      body: Column(
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('admin_uploads').doc(meterNumber).collection('billings').snapshots(),
              builder:(context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading();
                } else {
                    return Column(
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
                          child:
                            DropdownButton(
                                hint: hint,
                                disabledHint: hint,
                                isExpanded: true,
                                value: value,
                                items: snapshot.data?.docs.map((value) {
                                  return DropdownMenuItem(
                                    value: value.get('pdfUrl'),
                                    child: Center(
                                      child: Text(DateFormat.yMMMd().add_jm().format(DateTime.parse(value.get('datePublished').toDate().toString())))
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(
                                        () {
                                      this.value = value.toString();
                                    },
                                  );
                                },
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
                              onPressed: (){
                                launchURL(value!);
                              },
                              child: Text('DOWNLOAD BILLING STATEMENT')
                          )
                        ),
                      ],
                    );
                  }
              }
          )
        ],
      ),
    );
  }
}
launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}