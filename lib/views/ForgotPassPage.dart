import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forgot Password',
                    style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 20.sp, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Please enter your email',
                    style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Colors.grey, width: 1)),
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.envelope,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                  hintText: 'Enter here',
                                  contentPadding: EdgeInsets.symmetric(vertical: 2),
                                  hintStyle: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter email')));
                      } else {
                        setState(() {
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
                        });
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text).then((value) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reset email link sent successfuly!')));
                          }).catchError((e){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong! try again')));
                          });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50.h,
                      child: Center(
                        child: Text(
                          'Reset',
                          style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
