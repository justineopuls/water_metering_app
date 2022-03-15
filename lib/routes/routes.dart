import 'package:water_metering_app/screens/admin_home/admin_home.dart';
import 'package:water_metering_app/screens/admin_home/complaint_handling.dart';
import 'package:water_metering_app/screens/admin_home/database_checking.dart';
import 'package:water_metering_app/screens/admin_home/photo_upload.dart';
import 'package:water_metering_app/screens/customer_home/contact_us.dart';
import 'package:water_metering_app/screens/customer_home/customer_billing.dart';
import 'package:water_metering_app/screens/customer_home/customer_home.dart';
import 'package:water_metering_app/screens/customer_home/customer_records.dart';

class Routes {
  // Customer Routes
  static const String customerHome = CustomerHome.routeName;
  static const String customerProfile = CustomerProfile.routeName;
  static const String editProfile = EditProfile.routeName;
  static const String customerRecords = CustomerRecords.routeName;
  static const String customerBilling = CustomerBilling.routeName;
  static const String contactUs = ContactUs.routeName;

  // Admin Routes
  static const String adminHome = AdminHome.routeName;
  static const String complaintHandling = ComplaintHandling.routeName;
  static const String databaseChecking = DatabaseChecking.routeName;
  static const String photoUpload = PhotoUpload.routeName;
}
