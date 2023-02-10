import 'package:flutter/cupertino.dart';

import '../constant.dart';
import '../models/announce_model.dart';

class AnnounceProvider extends ChangeNotifier{
  List<AnnounceModel> announceList = [];

  Future fetchAllAnnouncements() async {
    var msg = await service.fetchDocuments('Announcement');

    if (announceList.isNotEmpty) {
      announceList.clear();
      msg.docs.forEach((doc) {
        AnnounceModel a = AnnounceModel.fromSnapshot(doc);
        announceList.add(a);
        notifyListeners();
      });
    } else {
      msg.docs.forEach((doc) {
        AnnounceModel a = AnnounceModel.fromSnapshot(doc);
        announceList.add(a);
        notifyListeners();
      });
    }
  }

  Future postAnnouncement(data) async {
    var msg = await service.postDocumentWithId(data['uid'], 'Announcement', data);
    if(msg['success'] == true){
      await fetchAllAnnouncements();
    }
    return msg;
  }

  Future updateAnnounce(uid, data) async {
    var msg = await service.updateDocument(uid, 'Announcement', data);
    if(msg['success'] == true){
      await fetchAllAnnouncements();
    }
    return msg;
  }
}