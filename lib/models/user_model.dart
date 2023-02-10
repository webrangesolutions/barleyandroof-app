import 'package:cloud_firestore/cloud_firestore.dart';
import '../constant.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? dob;
  String? nationality;
  String? passportId;
  String? passportExpiry;
  String? passType;
  String? passId;
  String? passExpiry;
  String? createdAt;
  String? profilePicture;
  bool? isVerify;
  List<dynamic>? paymentHistory;

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.get('uid') ?? '',
        name = snapshot.get('name') ?? '',
        email = snapshot.get('email') ?? '',
        phone = snapshot.get('phone') ?? '',
        dob = snapshot.get('dob') ?? '',
        nationality = snapshot.get('nationality') ?? '',
        passportId = snapshot.get('passportId') ?? '',
        passportExpiry = snapshot.get('passportExp') ?? '',
        passType = snapshot.get('passType') ?? '',
        passId = snapshot.get('passId') ?? '',
        passExpiry = snapshot.get('passExp') ?? '',
        createdAt = snapshot.get('createdAt') ?? todayDate,
        profilePicture = snapshot.get('profilePicture') ?? '',
        isVerify = snapshot.get('isVerify') ?? false,
        paymentHistory = snapshot.get('paymentHistory') ?? [];
}
