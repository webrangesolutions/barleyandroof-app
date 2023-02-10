import 'package:barleryroof/AdminView/AdminHomePage.dart';
import 'package:barleryroof/Views/BottomBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AdminView/AdminBottomBar.dart';
import 'LoginPage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    check();
    // TODO: implement initState
    super.initState();
  }
  check()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var data=await pref.getBool('login');
    var role=await pref.getBool('admin');
    if(data==true && role==true){
      Future.delayed(Duration(seconds:2)).then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>AdminBottomBarPage())));
    }else if(data==true){
      Future.delayed(Duration(seconds:2)).then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>BottomBarPage())));
    }else{
      Future.delayed(Duration(seconds:2)).then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>LoginPage())));
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill
          ),
        ),
        child: Center(
          child: Container(
            child: Image(image: AssetImage('assets/images/logo.png'),),
          ),
        ),
      ),
    );
  }
}
