import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/routes/routes.dart';
import 'package:water_metering_app/services/firestore_methods.dart';
import 'package:water_metering_app/utils/colors.dart';
import 'package:water_metering_app/utils/constants.dart';
import 'package:water_metering_app/utils/utils.dart';
import 'package:water_metering_app/widgets/meter_reader_drawer.dart';

class MeterReaderUpload extends StatefulWidget {
  const MeterReaderUpload({Key? key}) : super(key: key);

  static const String routeName = '/meter_reader_upload';

  @override
  State<MeterReaderUpload> createState() => _MeterReaderUploadState();
}

class _MeterReaderUploadState extends State<MeterReaderUpload> {
  Uint8List? _file;
  bool _isLoading = false;
  final TextEditingController _meterNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _selectImage(BuildContext context) async {
    Uint8List file = await pickImage(
      ImageSource.camera,
    );
    setState(() {
      _file = file;
    });
  }

  void uploadAdminImage(
    String uid,
    String uploadedBy,
    String photoLocation,
    String photoDateTime,
  ) async {
    setState(() {
      _isLoading = true;
    });
    if (_file != null) {
      try {
        String result = await FirestoreMethods().uploadAdminImage(
          _meterNumberController.text,
          _file!,
          uid,
          uploadedBy,
          photoLocation,
          photoDateTime,
        );

        if (result == 'success') {
          setState(() {
            _isLoading = false;
          });
          showSnackBar('Image upload successful.', context);
          Navigator.pushReplacementNamed(context, Routes.meterReaderUpload);
        } else {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(result, context);
          Navigator.pushReplacementNamed(context, Routes.meterReaderUpload);
        }
      } catch (e) {
        showSnackBar(e.toString(), context);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar('No image was selected. Please try again.', context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _meterNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Upload Image'),
      ),
      drawer: MeterReaderDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Complaint Details Form Field
              const Text('Meter Number'),
              TextFormField(
                controller: _meterNumberController,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Enter meter number'),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter the meter number.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),

              // Upload Image
              const Text('Upload Image of Water Meter'),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: Center(
                  child: _file != null
                      ? Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                            ),
                          ),
                        )
                      : const Text('Please select an image'),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton.icon(
                    label: const Text('Upload Photo'),
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () => _selectImage(context),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      onPrimary: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              // Upload Image Button
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Upload Image'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      uploadAdminImage(
                        user!.uid,
                        user.displayName,
                        'Test Location',
                        'Test Date Time',
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
