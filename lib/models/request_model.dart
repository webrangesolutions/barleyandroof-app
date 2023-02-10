import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel{
  String? uid;
  String? createdById;
  String? title;
  String? description;
  String? status;
  int? step;
  String? date;
  String? responseAdmin;
  bool? closed;

  RequestModel.fromSnapshot(DocumentSnapshot snapshot) :
      uid = snapshot.get('uid'),
      createdById = snapshot.get('createdById'),
      title = snapshot.get('title'),
      description = snapshot.get('description'),
      status = snapshot.get('status'),
      step = int.parse(snapshot.get('step')),
      date = snapshot.get('date'),
      responseAdmin = snapshot.get('responseAdmin'),
      closed = snapshot.get('closed');
}