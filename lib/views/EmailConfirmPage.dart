import 'package:barleryroof/Views/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailConfirmPage extends StatefulWidget {
  const EmailConfirmPage({Key? key}) : super(key: key);

  @override
  State<EmailConfirmPage> createState() => _EmailConfirmPageState();
}

class _EmailConfirmPageState extends State<EmailConfirmPage> {
  bool sendVerify = false;
  String btnTxt = "Verify";
  String verifyDescTxt =
      "Verify your email address by clicking the link sent to email address";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.black,
                  size: 30,
                )),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Confirmation',
                      style: GoogleFonts.nunitoSans(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '${verifyDescTxt + "\n" + (sendVerify == false ? (FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.email! : '') : "")}',
                      style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    GestureDetector(
                      onTap: (){
                        sendEmailVerification(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50.h,
                        child: Center(
                          child: Text(
                            '${btnTxt}',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: (){
                        sendEmailVerification(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.refresh),
                          SizedBox(width: 10.w,),
                          Text(
                            'Resend Code',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  sendEmailVerification(ctx) async {
    if (sendVerify == false) {

      showDialog(
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Center(
                child: Container(
                  height: 30,
                  width: 30,
                  color: Colors.transparent,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            );
          });

      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {
        sendVerify = true;
        btnTxt = "Back to SignIn";
        verifyDescTxt =
            "We have sent an email verification link.\nGo to SignIn by clicking\nBack to SignIn";
      });
      Navigator.pop(context);
    } else {
      FirebaseAuth.instance.signOut();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
    }
  }
}
