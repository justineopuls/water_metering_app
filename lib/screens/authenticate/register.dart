import 'package:water_metering_app/responsive/mobile_screen_layout.dart';
import 'package:water_metering_app/responsive/responsive_layout.dart';
import 'package:water_metering_app/responsive/web_screen_layout.dart';
import 'package:water_metering_app/screens/authenticate/sign_in.dart';
import 'package:water_metering_app/services/auth_methods.dart';
import 'package:water_metering_app/utils/colors.dart';
import 'package:water_metering_app/utils/constants.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/utils/utils.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _meterNumberController = TextEditingController();
  final _title = 'Water Metering App';
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    _meterNumberController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      displayName: _displayNameController.text,
      meterNumber: _meterNumberController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (result != 'success') {
      showSnackBar(result, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigateToSignIn() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              elevation: 0.0,
              title: Text(_title),
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    // Account Registration
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Account Registration',
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w500,
                            fontSize: 30.0),
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Email Form Field
                    TextFormField(
                      controller: _emailController,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Enter email'),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter an email.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),

                    // Password Form Field
                    TextFormField(
                      controller: _passwordController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Enter password'),
                      obscureText: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter a password.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),

                    // DisplayName Form Field
                    TextFormField(
                      controller: _displayNameController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Enter full name'),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your full name.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),

                    // Meter Number Form Field
                    TextFormField(
                      controller: _meterNumberController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Enter meter number'),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your meter number.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),

                    // Sign Up Button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: const Text('Register'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            signUpUser();
                          }
                        }),
                    const SizedBox(height: 12.0),

                    // Transition to Sign Up Page
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text("Already have an account?"),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        GestureDetector(
                          onTap: navigateToSignIn,
                          child: Container(
                            child: const Text(
                              "Sign in.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
