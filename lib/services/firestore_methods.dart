import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:water_metering_app/models/complaints.dart';
import 'package:water_metering_app/services/storage_methods.dart';

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
}
