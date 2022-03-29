import 'package:flutter/material.dart';
import 'package:water_metering_app/services/auth_methods.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:water_metering_app/utils/utils.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';

import '../../utils/constants.dart';

class AddCustomerAccount extends StatefulWidget {
  const AddCustomerAccount({Key? key}) : super(key: key);

  static const String routeName = '/add_customer_account';

  @override
  State<AddCustomerAccount> createState() => _AddCustomerAccountState();
}

class _AddCustomerAccountState extends State<AddCustomerAccount> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _meterNumberController = TextEditingController();

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
    String result = await AuthMethods().adminSignUpUser(
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
          builder: (context) => const AddCustomerAccount(),
        ),
      );
      showSnackBar('New User Account created successfully.', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              elevation: 0.0,
              title: const Text('Add Customer Account'),
            ),
            drawer: const AdminDrawer(),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
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
                        child: const Text('Create New Customer Account'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            signUpUser();
                          }
                        }),
                    const SizedBox(height: 12.0),
                  ],
                ),
              ),
            ),
          );
  }
}
