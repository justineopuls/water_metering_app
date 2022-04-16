// import 'package:flutter/material.dart';
// import 'package:water_metering_app/widgets/flexible_appbar.dart';
//
// class ComplaintViewPage extends StatelessWidget {
//   const ComplaintViewPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final double statusBarHeight = MediaQuery.of(context).padding.top;
//
//     return Scaffold(
//         body: CustomScrollView(slivers: [
//       FlexibleAppBar(_contact.fullName, _contact.imageUrl),
//       SliverList(
//           delegate: SliverChildListDelegate(<_ContactCategory>[
//         _buildPhoneCategory(),
//         _buildCategory(Icons.location_on, Icons.map,
//             <String>[_contact.location.street, _contact.location.city]),
//         _buildCategory(
//             Icons.contact_mail, Icons.email, <String>[_contact.email]),
//         _buildCategory(Icons.today, Icons.add_alert,
//             <String>["Birthday ${_contact.birthday}"]),
//       ]))
//     ]));
//   }
// }
