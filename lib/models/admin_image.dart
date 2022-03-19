import 'package:cloud_firestore/cloud_firestore.dart';

class AdminImage {
  final String meterNumber;
  final String uid;
  final String uploadedBy;
  final datePublished;
  final String uploadId;
  final String photoUrl;
  final String photoLocation;
  final String photoDateTime;

  const AdminImage({
    required this.meterNumber,
    required this.uid,
    required this.uploadedBy,
    required this.datePublished,
    required this.uploadId,
    this.photoUrl = '',
    this.photoLocation = '',
    this.photoDateTime = '',
  });

  Map<String, dynamic> toJson() => {
        'meterNumber': meterNumber,
        'uid': uid,
        'uploadedBy': uploadedBy,
        'datePublished': datePublished,
        'complaintId': uploadId,
        'photoUrl': photoUrl,
        'photoLocation': photoLocation,
        'photoDateTime': photoDateTime,
      };

  static AdminImage fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return AdminImage(
      meterNumber: snapshot['meterNumber'],
      uid: snapshot['uid'],
      uploadedBy: snapshot['uploadedBy'],
      datePublished: snapshot['datePublished'],
      uploadId: snapshot['uploadId'],
      photoUrl: snapshot['photoUrl'],
      photoLocation: snapshot['photoLocation'],
      photoDateTime: snapshot['photoDateTime'],
    );
  }
}
