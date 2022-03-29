import 'package:flutter/material.dart';
import 'package:water_metering_app/services/auth_methods.dart';
import 'package:water_metering_app/utils/constants.dart';
import 'package:water_metering_app/utils/loading.dart';
import 'package:water_metering_app/utils/utils.dart';
import 'package:water_metering_app/widgets/admin_drawer.dart';

class AddMeterReaderAccount extends StatefulWidget {
  const AddMeterReaderAccount({Key? key}) : super(key: key);

  static const String routeName = '/add_meter_reader_account';

  @override
  State<AddMeterReaderAccount> createState() => _AddMeterReaderAccountState();
}

class _AddMeterReaderAccountState extends State<AddMeterReaderAccount> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().adminSignUpMeterReader(
      email: _emailController.text,
      password: _passwordController.text,
      displayName: _displayNameController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (result != 'success') {
      showSnackBar(result, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AddMeterReaderAccount(),
        ),
      );
      showSnackBar('New Meter Reader Account created successfully.', context);
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
              title: const Text('Add Meter Reader Account'),
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

                    // Sign Up Button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: const Text('Create New Meter Reader Account'),
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
