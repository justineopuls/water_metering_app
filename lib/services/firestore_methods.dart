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
    String meterNumber,
  ) async {
    String result = 'Some error occured.';
    try {
      if (file != null) {
        print('File Selected');
        String complaintId = const Uuid().v1();
        String photoUrl = await StorageMethods().uploadImageToStorage(
            'complaints', file, true, complaintId, meterNumber, '', '');

        Complaint complaint = Complaint(
          description: description,
          uid: uid,
          displayName: displayName,
          datePublished: DateTime.now(),
          complaintId: complaintId,
          photoUrl: photoUrl,
          photoLocation: photoLocation,
          photoDateTime: photoDateTime,
          meterNumber: meterNumber,
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
          meterNumber: meterNumber,
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
        if (kIsWeb == false) {
          String pdfUrl = await StorageMethods()
              .uploadPdfToStorageFromMobile('billings/$meterNumber', file);
          String pdfId = const Uuid().v1();
          Billing billing = Billing(
            uid: uid,
            datePublished: DateTime.now(),
            pdfId: pdfId,
            pdfUrl: pdfUrl,
            photoLocation: photoLocation,
            photoDateTime: photoDateTime,
          );
          _firestore
              .collection('admin_uploads')
              .doc(meterNumber)
              .collection('billings')
              .doc(pdfId)
              .set(
                billing.toJson(),
              );
          result = 'success';
        } else {
          String pdfUrl = await StorageMethods()
              .uploadPdfToStorageFromWeb('billings/$meterNumber', file);
          String pdfId = const Uuid().v1();
          Billing billing = Billing(
            uid: uid,
            datePublished: DateTime.now(),
            pdfId: pdfId,
            pdfUrl: pdfUrl,
            photoLocation: photoLocation,
            photoDateTime: photoDateTime,
          );
          _firestore
              .collection('admin_uploads')
              .doc(meterNumber)
              .collection('billings')
              .doc(pdfId)
              .set(
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
        _firestore
            .collection('admin_uploads')
            .doc(meterNumber)
            .collection('billings')
            .doc(pdfId)
            .set(
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
    String numDigits,
    String numBlackDigits,
  ) async {
    String result = 'Some error occured.';
    try {
      String uploadId = const Uuid().v1();
      String photoUrl = await StorageMethods().uploadImageToStorage(
          'admin_uploads',
          file,
          false,
          uploadId,
          meterNumber,
          numBlackDigits,
          numDigits);

      AdminImage adminImage = AdminImage(
        meterNumber: meterNumber,
        uid: uid,
        uploadedBy: uploadedBy,
        datePublished: DateTime.now(),
        uploadId: uploadId,
        photoUrl: photoUrl,
        photoLocation: photoLocation,
        photoDateTime: photoDateTime,
        numDigits: numDigits,
        numBlackDigits: numBlackDigits,
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

  Future<String> markComplaintAsResolved(String complaintId) async {
    String result = 'Some error occured.';
    try {
      _firestore
          .collection('complaints')
          .doc(complaintId)
          .update({'isResolved': true});
      result = 'success';
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> verifyUserAccount(String uid) async {
    String result = 'Some error occured.';
    try {
      _firestore.collection('users').doc(uid).update({'isVerified': true});
      result = 'success';
    } catch (e) {
      result = e.toString();
    }
    return result;
  }
}
