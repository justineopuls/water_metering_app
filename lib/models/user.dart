import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String email;
  final String uid;
  final String displayName;
  final String meterNumber;
  final String userType;
  final bool isVerified;
  final String phoneNumber;

  const MyUser({
    required this.displayName,
    required this.uid,
    required this.email,
    required this.meterNumber,
    this.userType = 'customer',
    this.isVerified = false,
    this.phoneNumber = '',
  });

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'uid': uid,
        'email': email,
        'meterNumber': meterNumber,
        'userType': userType,
        'isVerified': isVerified,
        'phoneNumber': phoneNumber,
      };

  static MyUser fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return MyUser(
      displayName: snapshot['displayName'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      meterNumber: snapshot['meterNumber'],
      userType: snapshot['userType'],
      isVerified: snapshot['isVerified'],
      phoneNumber: snapshot['phoneNumber'],
    );
  }
}
