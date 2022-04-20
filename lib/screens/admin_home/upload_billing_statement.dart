import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:water_metering_app/providers/user_provider.dart';
import 'package:water_metering_app/services/firestore_methods.dart';
import 'package:water_metering_app/utils/colors.dart';
import 'package:water_metering_app/utils/constants.dart';
import 'package:water_metering_app/utils/utils.dart';

class UploadBillingStatement extends StatefulWidget {
  static const String routeName = '/upload_billing_statement';

  const UploadBillingStatement(
      {Key? key, required this.meterNumber, required this.uid})
      : super(key: key);
  final String meterNumber;
  final String uid;

  @override
  _UploadBillingStatementState createState() => _UploadBillingStatementState();
}

class _UploadBillingStatementState extends State<UploadBillingStatement> {
  var file, _file;
  String fileName = '', displayText = 'No file chosen', buttonText = 'BROWSE';
  Color fileTextColor = Colors.black38;
  bool _isLoading = false;
  bool _isFileLoaded = false;

  // Choose pdf file from local storage
  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    if (kIsWeb) {
      file = result.files.first;
      fileName = file.name;
      file = file.bytes;
    } else {
      _file = result.files.first;
      fileName = _file.name;
      file = File(_file.path);
    }
    _isFileLoaded = true;
    updateText();
  }

  void updateText() {
    setState(() {
      displayText = fileName;
      buttonText = 'UPLOAD';
      fileTextColor = Colors.black;
    });
  }

  void uploadFile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String result = await FirestoreMethods().uploadBillingStatement(
        file,
        widget.uid,
        widget.meterNumber,
        'photoLocation',
        'photoDateTime',
      );

      if (result == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Upload successful.', context);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Bill'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_isFileLoaded) {
                            uploadFile();
                          } else {
                            _pickFiles();
                          }
                        },
                        child: Text(buttonText)),
                    const SizedBox(width: 10),
                    Text(
                      displayText,
                      style: TextStyle(color: fileTextColor),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
