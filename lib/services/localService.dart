import '../constant.dart';

class LocalService {

  setUserId(uid) async {
    prefs!.setString('uid', uid);
  }

  setAdmin(val) async {
    prefs!.setBool('admin', val);
  }

  clearAdmin(){
    if(prefs!.get('admin') != null){
      prefs!.clear();
    }
  }

  clearUserId(){
    if(prefs!.get('uid') != null){
      prefs!.clear();
    }
  }
}