import 'package:cloud_firestore/cloud_firestore.dart';

class Billing {
  final String uid;
  final datePublished;
  final String pdfId;
  final String pdfUrl;
  final String photoLocation;
  final String photoDateTime;

  const Billing({
    required this.uid,
    required this.datePublished,
    required this.pdfId,
    this.pdfUrl = '',
    this.photoLocation = '',
    this.photoDateTime = '',
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'datePublished': datePublished,
        'pdfId': pdfId,
        'pdfUrl': pdfUrl,
        'photoLocation': photoLocation,
        'photoDateTime': photoDateTime,
      };

  static Billing fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Billing(
      uid: snapshot['uid'],
      datePublished: snapshot['datePublished'],
      pdfId: snapshot['pdfId'],
      pdfUrl: snapshot['pdfUrl'],
      photoLocation: snapshot['photoLocation'],
      photoDateTime: snapshot['photoDateTime'],
    );
  }
}
