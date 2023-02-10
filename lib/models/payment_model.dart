import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel{
  String? uid;
  String? unitTitle;
  String? roomTitle;
  String? selectedUser;
  String? paymentType;
  String? amount;
  String? dueDate;
  String? remark;
  String? invoice;

  PaymentModel.fromSnapshot(DocumentSnapshot snapshot) :
      uid = snapshot.get('uid') ?? '',
      unitTitle = snapshot.get('unitTitle') ?? '',
      roomTitle = snapshot.get('roomTitle') ?? '',
      selectedUser = snapshot.get('selectedUser') ?? '',
      paymentType = snapshot.get('paymentType') ?? '',
      amount = snapshot.get('amount') ?? '',
      dueDate = snapshot.get('dueDate') ?? '',
      remark = snapshot.get('remark') ?? '',
      invoice = snapshot.get('invoice') ?? '';
}