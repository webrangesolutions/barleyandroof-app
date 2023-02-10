import 'dart:io';

import 'package:barleryroof/models/request_model.dart';
import 'package:flutter/cupertino.dart';

import '../constant.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  int selectedTab = 0;

  UserModel? user;
  RequestModel? request;
  List<UserModel> usersList = [];
  List<RequestModel> requestsList = [];

  bool isLoading = false;
  File? userPicture;

  setSelectedTab(val) {
    selectedTab = val;
    notifyListeners();
  }

  setUserMedia(val) {
      userPicture = val;
      notifyListeners();
  }

  setIsLoading(val) {
    isLoading = val;
    notifyListeners();
  }

  Future signInUser(email, password) async {
    var mmsg = {};

    var msg = await service.signIn(email, password);

    if(msg.data() != null){
      lService.setUserId(msg['uid']);
      user = UserModel.fromSnapshot(msg);
      mmsg.addAll({'success': true});
      notifyListeners();
    }else{
      mmsg.addAll({'success': false});
    }

    return mmsg;
  }

  Future signUpUser(data, pass) async {
    var msg = {};

    var smsg = await service.signUp(data, pass);
    if (smsg.data() != null) {
      lService.setUserId(smsg['uid']);
      user = UserModel.fromSnapshot(smsg);
      msg.addAll({'success': true});
      notifyListeners();
    } else {
      msg.addAll({'success': false});
    }

    return msg;
  }

  Future fetchUserById(uid) async {
    var msg = await service.fetchDocumentById(uid, "Users");
    user = UserModel.fromSnapshot(msg);
    notifyListeners();
  }

  Future fetchAllUser() async {
    var msg = await service.fetchDocuments("Users");

    if(usersList.isNotEmpty){
      usersList.clear();

      msg.docs.forEach((doc) {
        UserModel u = UserModel.fromSnapshot(doc);
        usersList.add(u);
        notifyListeners();
      });
    }else{
      msg.docs.forEach((doc) {
        UserModel u = UserModel.fromSnapshot(doc);
        usersList.add(u);
        notifyListeners();
      });
    }
  }

  Future postUserRequest(data) async {
    var msg = await service.postDocumentWithId(data['uid'], 'Requests', data);
    if(msg['success'] == true){
      await fetchAllRequests();
    }
    return msg;
  }

  Future fetchRequestById(uid) async {
    var msg = await service.fetchDocumentById(uid, "Requests");
    request = RequestModel.fromSnapshot(msg);
    notifyListeners();
  }

  Future fetchAllRequests() async {
    var msg = await service.fetchDocuments("Requests");

    if(requestsList.isNotEmpty){
      requestsList.clear();

      msg.docs.forEach((doc) {
        RequestModel r = RequestModel.fromSnapshot(doc);
        requestsList.add(r);
        notifyListeners();
      });
    }else{
      msg.docs.forEach((doc) {
        RequestModel r = RequestModel.fromSnapshot(doc);
        requestsList.add(r);
        notifyListeners();
      });
    }
  }

  Future updateUser(uid, data) async {
    var msg = await service.updateDocument(uid, "Users", data);
    return msg;
  }

  Future updateRequest(uid, data) async {
    var msg = await service.updateDocument(uid, "Requests", data);
    await fetchAllRequests();
    return msg;
  }

  Future<String> postStorage(dir,data) async {
    var msg = await service.postStorage(dir, data);
    return msg;
  }

  Future sendEmailVerificationLink(email) async {
    await service.verifyEmail(email);
  }

  Future signOutUser() async {
    lService.clearUserId();
    var msg = await service.signOut();
    return msg;
  }
}
