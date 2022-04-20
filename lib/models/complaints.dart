import 'package:cloud_firestore/cloud_firestore.dart';

class Complaint {
  final String description;
  final String uid;
  final String displayName;
  final datePublished;
  final String complaintId;
  final String photoUrl;
  final String photoLocation;
  final String photoDateTime;
  final bool isResolved;
  final String meterNumber;

  const Complaint({
    required this.description,
    required this.uid,
    required this.displayName,
    required this.datePublished,
    required this.complaintId,
    this.photoUrl = '',
    this.photoLocation = '',
    this.photoDateTime = '',
    this.isResolved = false,
    required this.meterNumber,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'displayName': displayName,
        'datePublished': datePublished,
        'complaintId': complaintId,
        'photoUrl': photoUrl,
        'photoLocation': photoLocation,
        'photoDateTime': photoDateTime,
        'isResolved': isResolved,
        'meterNumber': meterNumber,
      };

  static Complaint fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Complaint(
        description: snapshot['description'],
        uid: snapshot['uid'],
        displayName: snapshot['displayName'],
        datePublished: snapshot['datePublished'],
        complaintId: snapshot['complaintId'],
        photoUrl: snapshot['photoUrl'],
        photoLocation: snapshot['photoLocation'],
        photoDateTime: snapshot['photoDateTime'],
        isResolved: snapshot['isResolved'],
        meterNumber: snapshot['meterNumber']);
  }
}
