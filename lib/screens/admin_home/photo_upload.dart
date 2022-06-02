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
import 'package:water_metering_app/widgets/admin_drawer.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoUpload extends StatefulWidget {
  const PhotoUpload({Key? key}) : super(key: key);

  static const String routeName = '/photo_upload';

  @override
  State<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  var _file;
  bool _isLoading = false;
  String photoLocation = '';
  var photoDateTime = '';
  final TextEditingController _meterNumberController = TextEditingController();
  final TextEditingController _numDigitsController = TextEditingController();
  final TextEditingController _numBlackDigitsController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String ButtonLabel = 'Take Photo';

  _selectImage(BuildContext context) async {
    await Permission.camera.request().isGranted;
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    Uint8List? bytes = await file?.readAsBytes();
    //String location = await getExifLocation(bytes);
    String dateTime = await getExifDateTime(bytes);
    setState(() {
      _file = bytes;
      photoLocation = 'location';
      photoDateTime = dateTime;
      ButtonLabel = 'Upload Photo';
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
          _file,
          uid,
          uploadedBy,
          photoLocation,
          photoDateTime,
          _numDigitsController.text,
          _numBlackDigitsController.text,
        );

        if (result == 'success') {
          setState(() {
            _isLoading = false;
          });
          showSnackBar('Image upload successful.', context);
          Navigator.pushReplacementNamed(context, Routes.photoUpload);
        } else {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(result, context);
          Navigator.pushReplacementNamed(context, Routes.photoUpload);
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
      drawer: AdminDrawer(),
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
              const SizedBox(height: 5),
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

              const Text('Number of Total Digits'),
              const SizedBox(height: 5),
              TextFormField(
                controller: _numDigitsController,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Enter number of digits present'),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter the number of digits in the meter.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),

              const Text('Number of Black Digits'),
              const SizedBox(height: 5),
              TextFormField(
                controller: _numBlackDigitsController,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Enter number of black digits present'),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter the number of black digits in the meter.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),

              // Upload Image
              const Text('Selected Image'),
              const SizedBox(height: 5),
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
              const SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton.icon(
                    label: Text(ButtonLabel),
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {
                      if (_file == null) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title:
                                const Text('Ensure the meter dial is visible'),
                            content: Image.network(
                                'https://i.imgur.com/B3dDZWN.png'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                  _selectImage(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        if (_formKey.currentState!.validate()) {
                          uploadAdminImage(
                            user!.uid,
                            user.displayName,
                            photoLocation,
                            photoDateTime,
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      onPrimary: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
              //const SizedBox(height: 20.0),

              // Upload Image Button
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.teal, // background
              //       onPrimary: Colors.white, // foreground
              //     ),
              //     child: _isLoading
              //         ? const Center(
              //             child: CircularProgressIndicator(),
              //           )
              //         : const Text('Upload Image'),
              //     onPressed: () {
              //       if (_formKey.currentState!.validate()) {
              //         uploadAdminImage(
              //           user!.uid,
              //           user.displayName,
              //           photoLocation,
              //           photoDateTime,
              //         );
              //       }
              //     }),

              // TextButton(
              //     onPressed: () async{
              //         if (await Permission.camera.request().isGranted) {
              //           showSnackBar('access granted',context);
              //         }
              //         setState(() {});
              //       var status = await Permission.camera.status;
              //       if (status.isGranted){
              //         showDialog<String>(
              //             context: context,
              //             builder: (BuildContext context) => AlertDialog(
              //               title: const Text('grant'),
              //               content: Text('yes'),
              //               actions: <Widget>[
              //                 TextButton(
              //                   onPressed: () => Navigator.pop(context, 'Cancel'),
              //                   child: const Text('Cancel'),
              //                 ),
              //                 TextButton(
              //                   onPressed: () {
              //                     Navigator.pop(context, 'OK');
              //                   },
              //                   child: const Text('OK'),
              //                 ),
              //               ],
              //         ),
              //         );
              //       } else{
              //         print('no permision');
              //       }
              //     },
              //     child: Text('test')
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
