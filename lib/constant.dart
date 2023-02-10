import 'dart:math';

import 'package:barleryroof/services/firebaseService.dart';
import 'package:barleryroof/services/localService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
SharedPreferences? prefs;

FirebaseService service = FirebaseService();
LocalService lService = LocalService();

var todayDate =
    '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

showToast(msg) {
  Fluttertoast.showToast(
      msg: msg, backgroundColor: Colors.black, toastLength: Toast.LENGTH_SHORT);
}

String errorTxt = 'Something went wrong! try again';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

Widget LoadingWidget(ctx) {
  return Container(
    height: MediaQuery.of(ctx).size.height,
    width: MediaQuery.of(ctx).size.width,
    color: Colors.transparent,
    child: Center(
      child: Container(
        height: 30,
        width: 30,
        color: Colors.transparent,
        child: CircularProgressIndicator(
          color: Theme.of(ctx).primaryColor,
        ),
      ),
    ),
  );
}
var filters = {};
