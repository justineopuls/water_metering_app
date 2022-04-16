import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/screens/admin_home/upload_billing_statement.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';


class ViewCustomerBilling extends StatefulWidget {
  const ViewCustomerBilling({Key? key, required this.meterNumber, required this.uid}) : super(key: key);
  static const String routeName = '/customer_billing';
  final String meterNumber;
  final String uid;

  @override
  _ViewCustomerBillingState createState() => _ViewCustomerBillingState();
}

class _ViewCustomerBillingState extends State<ViewCustomerBilling> {

  final Widget? hint = const Text('Please choose billing date...',
      style: TextStyle(fontStyle: FontStyle.italic));
  String? value;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('View Customer Billing'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('admin_uploads').doc(widget.meterNumber).collection('billings').snapshots(),
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
                      ElevatedButton(
                          onPressed: (){
                            launchURL(value!);
                          },
                          child: Text('DOWNLOAD BILLING STATEMENT')
                      )
                    ]
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