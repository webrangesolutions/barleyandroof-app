import 'package:cloud_firestore/cloud_firestore.dart';

class AnnounceModel{
  String? uid;
  String? title;
  String? description;
  String? timestamp;
  String? project;
  String? type;

  AnnounceModel.fromSnapshot(DocumentSnapshot snapshot) :
      uid = snapshot.get('uid') ?? '',
      title = snapshot.get('title') ?? '',
      description = snapshot.get('description') ?? '',
      timestamp = snapshot.get('timestamp') ?? '',
      project = snapshot.get('project') ?? '',
      type = snapshot.get('type') ?? '';
}