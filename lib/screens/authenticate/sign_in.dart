import 'package:water_metering_app/responsive/mobile_screen_layout.dart';
import 'package:water_metering_app/responsive/responsive_layout.dart';
import 'package:water_metering_app/responsive/web_screen_layout.dart';
import 'package:water_metering_app/screens/authenticate/register.dart';
import 'package:water_metering_app/services/auth_methods.dart';
import 'package:water_metering_app/utils/colors.dart';
import 'package:water_metering_app/utils/constants.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:water_metering_app/utils/utils.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _title = 'Water Metering App';
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (result == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(result, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToRegister() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Register(),
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
                    // Login
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
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
                    const SizedBox(height: 12.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: const Text('Sign In'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            loginUser();
                          }
                        }),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text("Don't have an account?"),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        GestureDetector(
                          onTap: navigateToRegister,
                          child: Container(
                            child: const Text(
                              "Sign up.",
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
