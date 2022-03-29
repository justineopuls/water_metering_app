import 'package:flutter/material.dart';
import 'package:water_metering_app/screens/authenticate/sign_in.dart';
import 'package:water_metering_app/services/auth_methods.dart';

class UserNotVerified extends StatelessWidget {
  const UserNotVerified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('User Not Verified'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: const Text(
                  'This user is currently unverified. Please wait for a customer service representative to validate your account.'),
            ),

            const SizedBox(height: 20.0),

            // Sign Up Button
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: const Text('Sign Out'),
                onPressed: () {
                  AuthMethods().signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
