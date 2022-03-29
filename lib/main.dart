import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/responsive/mobile_screen_layout.dart';
import 'package:water_metering_app/responsive/responsive_layout.dart';
import 'package:water_metering_app/responsive/web_screen_layout.dart';
import 'package:water_metering_app/routes/routes.dart';
import 'package:water_metering_app/screens/admin_home/add_meter_reader_account.dart';
import 'package:water_metering_app/screens/admin_home/admin_home.dart';
import 'package:water_metering_app/screens/admin_home/complaint_handling.dart';
import 'package:water_metering_app/screens/admin_home/add_customer_account.dart';
import 'package:water_metering_app/screens/admin_home/database_checking.dart';
import 'package:water_metering_app/screens/admin_home/photo_upload.dart';
import 'package:water_metering_app/screens/admin_home/validate_customer_account.dart';
import 'package:water_metering_app/screens/authenticate/sign_in.dart';
import 'package:water_metering_app/screens/customer_home/contact_us.dart';
import 'package:water_metering_app/screens/customer_home/customer_billing.dart';
import 'package:water_metering_app/screens/customer_home/customer_home.dart';
import 'package:water_metering_app/screens/customer_home/customer_profile.dart';
import 'package:water_metering_app/screens/customer_home/edit_profile.dart';
import 'package:water_metering_app/screens/meter_reader_home/meter_reader_home.dart';
import 'package:water_metering_app/screens/meter_reader_home/meter_reader_upload.dart';
import 'package:water_metering_app/widgets/change_username.dart';
import 'package:water_metering_app/widgets/change_email.dart';
import 'package:water_metering_app/widgets/change_number.dart';
import 'package:water_metering_app/widgets/change_password.dart';
import 'package:water_metering_app/screens/customer_home/customer_records.dart';
import 'package:water_metering_app/utils/colors.dart';
import 'package:water_metering_app/utils/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyDjt6xzk6woa5QvNfOJHkSl7bfZHAD64hg',
      appId: '1:856960125509:web:3245a21d47e0bc8e96b12c',
      messagingSenderId: '856960125509',
      projectId: 'water-metering-app',
      storageBucket: 'water-metering-app.appspot.com',
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Water Metering App',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }

            return const SignIn();
          },
        ),
        routes: {
          // Customer Routes
          Routes.customerHome: (context) => const CustomerHome(),
          Routes.customerProfile: (context) => const CustomerProfile(),
          Routes.editProfile: (context) => const EditProfile(),
          Routes.changeUsername: (context) => const ChangeUsername(),
          Routes.changeEmail: (context) => const ChangeEmail(),
          Routes.changeNumber: (context) => const ChangeNumber(),
          Routes.changePassword: (context) => const ChangePassword(),
          Routes.customerRecords: (context) => const CustomerRecords(),
          Routes.customerBilling: (context) => const CustomerBilling(),
          Routes.contactUs: (context) => const ContactUs(),

          // Admin Routes
          Routes.adminHome: (context) => const AdminHome(),
          Routes.complaintHandling: (context) => const ComplaintHandling(),
          Routes.databaseChecking: (context) => const DatabaseChecking(),
          Routes.photoUpload: (context) => const PhotoUpload(),
          Routes.addCustomerAccount: (context) => const AddCustomerAccount(),
          Routes.addMeterReaderAccount: (context) =>
              const AddMeterReaderAccount(),
          Routes.validateCustomerAccount: (context) =>
              const ValidateCustomerAccount(),

          // Meter Reader Routes
          Routes.meterReaderHome: (context) => const MeterReaderHome(),
          Routes.meterReaderUpload: (context) => const MeterReaderUpload(),
        },
      ),
    );
  }
}
