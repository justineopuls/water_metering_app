import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/widgets/change_username.dart';
import '../../routes/routes.dart';
import '../../widgets/admin_drawer.dart';
import '../../widgets/change_email.dart';
import '../../widgets/change_number.dart';
import '../../widgets/change_password.dart';

class ViewCustomerDetails extends StatefulWidget {
  const ViewCustomerDetails({Key? key, required this.uid}) : super(key: key);
  static const String routeName = '/view_customer_records';
  final String uid;

  @override
  _ViewCustomerDetailsState createState() => _ViewCustomerDetailsState();
}

class _ViewCustomerDetailsState extends State<ViewCustomerDetails> {
  @override
  Widget build(BuildContext context) {
    //String currentMeterNumber = meterNumber;
    //final MyUser? user = Provider.of<UserProvider>(context).getUser;
    //final String? uid = user?.uid;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.teal,
                  title: Text('Account Information'),
                ),
                drawer: AdminDrawer(),
                body: ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    ListTile(
                      title: Text(
                        "Account Name",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(snapshot.data!.data()['displayName']),
                      trailing: Icon(Icons.chevron_right, size: 30),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChangeUsername(uid: widget.uid),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Phone Number",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(snapshot.data!.data()['phoneNumber']),
                      trailing: Icon(Icons.chevron_right, size: 30),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNumber(uid: widget.uid),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(snapshot.data!.data()['email']),
                      trailing: Icon(Icons.chevron_right, size: 30),
                      onTap: () {},
                    ),
                  ],
                ));
          }
        });
  }
}
