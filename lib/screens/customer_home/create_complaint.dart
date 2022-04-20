import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/services/firestore_methods.dart';
import 'package:water_metering_app/utils/colors.dart';
import 'package:water_metering_app/utils/constants.dart';
import 'package:water_metering_app/utils/utils.dart';

class CreateComplaint extends StatefulWidget {
  const CreateComplaint({Key? key}) : super(key: key);

  @override
  State<CreateComplaint> createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
  Uint8List? _file;
  bool _isLoading = false;
  String photoLocation = '';
  var photoDateTime = '';
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Upload an Image'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20.0),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  String location = await getExifLocation(file);
                  String dateTime = await getExifDateTime(file);
                  setState(() {
                    _file = file;
                    photoLocation = location;
                    photoDateTime = dateTime;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20.0),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  String location = await getExifLocation(file);
                  String dateTime = await getExifDateTime(file);
                  setState(() {
                    _file = file;
                    photoLocation = location;
                    photoDateTime = dateTime;
                  });
                },
              ),
            ],
          );
        });
  }

  void postComplaint(
    String uid,
    String displayName,
    String photoLocation,
    String photoDateTime,
    String meterNumber,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String result = await FirestoreMethods().uploadComplaint(
        _descriptionController.text,
        _file,
        uid,
        displayName,
        photoLocation,
        photoDateTime,
        meterNumber,
      );

      if (result == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(
            'Complaint Sent! Please wait for a customer service representative to contact you.',
            context);
        Navigator.pop(context);
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(result, context);
        Navigator.pop(context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Submit Ticket'),
      ),
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
              const Text('Complaint Information'),
              TextFormField(
                maxLines: 8,
                controller: _descriptionController,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Enter complaint information'),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter your complaint details.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),

              // Add Optional Image
              const Text('Upload Image of Water Meter'),
              const Text('Optional'),
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

              // Submit Complaint Button
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Submit Ticket'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      postComplaint(
                        user!.uid,
                        user.displayName,
                        photoLocation,
                        photoDateTime,
                        user.meterNumber,
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
