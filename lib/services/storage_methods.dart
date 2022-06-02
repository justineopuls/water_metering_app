import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add image to firebase storage
  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    bool isComplaint,
    String imageID,
    String meterNumber,
    String numBlackDigits,
    String numDigits,
  ) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    String path = '';
    path = imageID +
        "_" +
        meterNumber +
        "_" +
        numBlackDigits +
        "_" +
        numDigits +
        ".jpg";
    ref = ref.child(path);
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    // 2nd image upload for processing
    if (isComplaint == false) {
      UploadTask uploadTask2 =
          _storage.ref().child('for_processing').child(path).putData(file);
    }
    return downloadUrl;
  }

  // Add pdf to firebase storage
  Future<String> uploadPdfToStorageFromMobile(String childName, file) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    String pdfId = const Uuid().v1();
    ref = ref.child(pdfId);
    UploadTask uploadTask =
        ref.putFile(file, SettableMetadata(contentType: 'application/pdf'));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadPdfToStorageFromWeb(String childName, file) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    String pdfId = const Uuid().v1();
    ref = ref.child(pdfId);
    UploadTask uploadTask =
        ref.putData(file, SettableMetadata(contentType: 'application/pdf'));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
