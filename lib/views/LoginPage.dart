import 'package:barleryroof/AdminView/AdminHomePage.dart';
import 'package:barleryroof/Views/EmailConfirmPage.dart';
import 'package:barleryroof/Views/ForgotPassPage.dart';
import 'package:barleryroof/widgets/custom_txtfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AdminView/AdminBottomBar.dart';
import '../constant.dart';
import '../providers/user_provider.dart';
import 'AllRoomsPage.dart';
import 'BottomBar.dart';
import 'SignupPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var admin = 'c';
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: user.isLoading == false ?
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill),
          ),
          child: Column(children: [
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => AllRoomsPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Center(
                      child: Text(
                        'Skip',
                        style: GoogleFonts.nunitoSans(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            Container(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                height: 100.h,
                width: 100.h,
              ),
            ),
            Spacer(),
            Spacer(),
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: GoogleFonts.nunitoSans(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'Please enter your details',
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  SizedBox(height: 10.h,),
                  CustomTxtField1(prefixIcon: Icons.person, label: 'Email', hint: 'Enter here', txt: email, enabled: true, lines: 1),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTxtField1(prefixIcon: Icons.lock, label: 'Password', hint: 'Enter here', txt: password, enabled: true, lines: 1, obscure: true),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h, bottom: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter email')));
                      } else if (password.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter password')));
                      } else {
                        signIn(context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      height: 50.h,
                      child: Center(
                        child: Text(
                          'Login',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SignupPage()));
                    },
                    child: Text(
                      'Don\'t have an account? You can Register\nhere.',
                      style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            )
          ]),
        ),
      ) : LoadingWidget(context),
    );
  }

  signIn(ctx) async {
    var user = Provider.of<UserProvider>(ctx, listen: false);

    user.setIsLoading(true);

    user
        .signInUser(email.text.trim(), password.text.trim())
        .then((value) async {
      user.setIsLoading(false);

      if (value['success'] == true) {
        if(email.text.toLowerCase() == 'admin@gmail.com'){
          print('yes');
          lService.setAdmin(true);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (_) => AdminBottomBarPage()));
        }else{
          lService.setAdmin(false);

          if (firebaseAuth.currentUser!.emailVerified) {
            await user.updateUser(user.user!.uid, {'isVerify': true});
            await user.fetchUserById(user.user!.uid);
          }

          if (user.user!.isVerify == true) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (_) => BottomBarPage()));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => EmailConfirmPage()));
          }
        }
      }
    }).catchError((e) {
      user.setIsLoading(false);
      print(e);
      // if (e.code == 'user-not-found') {
      //   showToast('User with this email not found !');
      // } else if (e.code == 'invalid-email') {
      //   showToast('Invalid email! enter correct email.');
      // } else if (e.code == 'wrong-password') {
      //   showToast('Your password is incorrect.');
      // } else {
        showToast(errorTxt);
      // }
    });
  }
}
