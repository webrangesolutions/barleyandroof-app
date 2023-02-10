import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel{
  String? uid;
  String? bookBy;
  String? roomId;
  String? unitId;
  double? payment;
  String? status;
  String? paymentDate;
  String? startDate;
  String? endDate;
  int? period;
  int? step;
  String? reason;
  String? receipt;
  String? agreement;
  List<dynamic>? workPass;
  List<dynamic>? passport;

  BookingModel.fromSnapshot(DocumentSnapshot snapshot) :
      uid = snapshot.get('uid') ?? '',
      bookBy = snapshot.get('bookBy') ?? '',
      roomId = snapshot.get('roomId') ?? '',
      unitId = snapshot.get('unitId') ?? '',
      payment = double.parse(snapshot.get('payment')),
      period = snapshot.get('period') ?? '',
      status = snapshot.get('status') ?? '',
      paymentDate = snapshot.get('paymentDate') ?? '',
      startDate = snapshot.get('startDate') ?? '',
      endDate = snapshot.get('endDate') ?? '',
      step = snapshot.get('step'),
      receipt = snapshot.get('receipt'),
      agreement = snapshot.get('agreement'),
      reason = snapshot.get('reason') ?? '',
      workPass = snapshot.get('workPass') ?? [],
      passport = snapshot.get('passport') ?? [];
}