import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:water_metering_app/models/admin_image.dart';
import 'package:water_metering_app/models/complaints.dart';
import 'package:water_metering_app/services/storage_methods.dart';
import '../models/billings.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Upload Complaint
  Future<String> uploadComplaint(
    String description,
    Uint8List? file,
    String uid,
    String displayName,
    String photoLocation,
    String photoDateTime,
  ) async {
    String result = 'Some error occured.';
    try {
      if (file != null) {
        print('File Selected');
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('complaints', file, true);

        String complaintId = const Uuid().v1();
        Complaint complaint = Complaint(
          description: description,
          uid: uid,
          displayName: displayName,
          datePublished: DateTime.now(),
          complaintId: complaintId,
          photoUrl: photoUrl,
          photoLocation: photoLocation,
          photoDateTime: photoDateTime,
        );

        _firestore.collection('complaints').doc(complaintId).set(
              complaint.toJson(),
            );
        result = 'success';
      } else {
        String complaintId = const Uuid().v1();
        Complaint complaint = Complaint(
          description: description,
          uid: uid,
          displayName: displayName,
          datePublished: DateTime.now(),
          complaintId: complaintId,
        );

        _firestore.collection('complaints').doc(complaintId).set(
              complaint.toJson(),
            );
        result = 'success';
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  // Upload Billing Statement
  Future<String> uploadBillingStatement(
      file,
      String uid,
      String meterNumber,
      String photoLocation,
      String photoDateTime,
      ) async {
    String result = 'Some error occured.';
    try {
      if (file != null) {
        print('File Selected');
        if (kIsWeb == false){
          String pdfUrl = await StorageMethods().uploadPdfToStorageFromMobile('billings/$meterNumber', file);
          String pdfId = const Uuid().v1();
          Billing billing = Billing(
            uid: uid,
            datePublished: DateTime.now(),
            pdfId: pdfId,
            pdfUrl: pdfUrl,
            photoLocation: photoLocation,
            photoDateTime: photoDateTime,
          );
          _firestore.collection('admin_uploads').doc(meterNumber).collection('billings').doc(pdfId).set(
            billing.toJson(),
          );
          result = 'success';
        } else {
          String pdfUrl = await StorageMethods().uploadPdfToStorageFromWeb('billings/$meterNumber', file);
          String pdfId = const Uuid().v1();
          Billing billing = Billing(
            uid: uid,
            datePublished: DateTime.now(),
            pdfId: pdfId,
            pdfUrl: pdfUrl,
            photoLocation: photoLocation,
            photoDateTime: photoDateTime,
          );
          _firestore.collection('admin_uploads').doc(meterNumber).collection('billings').doc(pdfId).set(
            billing.toJson(),
          );
          result = 'success';
        }
      } else {
        String pdfId = const Uuid().v1();
        Billing billing = Billing(
          uid: uid,
          datePublished: DateTime.now(),
          pdfId: pdfId,
        );
        _firestore.collection('admin_uploads').doc(meterNumber).collection('billings').doc(pdfId).set(
          billing.toJson(),
        );
        result = 'success';
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> uploadAdminImage(
    String meterNumber,
    Uint8List file,
    String uid,
    String uploadedBy,
    String photoLocation,
    String photoDateTime,
  ) async {
    String result = 'Some error occured.';
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('admin_uploads', file, true);

      String uploadId = const Uuid().v1();
      AdminImage adminImage = AdminImage(
        meterNumber: meterNumber,
        uid: uid,
        uploadedBy: uploadedBy,
        datePublished: DateTime.now(),
        uploadId: uploadId,
        photoUrl: photoUrl,
        photoLocation: photoLocation,
        photoDateTime: photoDateTime,
      );

      _firestore
          .collection('admin_uploads')
          .doc(meterNumber)
          .collection('readings')
          .doc(uploadId)
          .set(
            adminImage.toJson(),
          );
      result = 'success';
    } catch (e) {
      result = e.toString();
    }
    return result;
  }
}
