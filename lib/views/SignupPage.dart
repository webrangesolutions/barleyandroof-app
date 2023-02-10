
import 'package:barleryroof/widgets/custom_txtfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../providers/user_provider.dart';
import 'EmailConfirmPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var accept = false;
  TextEditingController name = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController dob = new TextEditingController();
  TextEditingController nationality = new TextEditingController();
  TextEditingController passportId = new TextEditingController();
  TextEditingController passportExpiryDate = new TextEditingController();
  TextEditingController passType = new TextEditingController();
  TextEditingController passId = new TextEditingController();
  TextEditingController passExpiryDate = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: user.isLoading == false ?
      SingleChildScrollView(
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
                    'Register',
                    style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 20.sp, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Please enter your details',
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
                          CupertinoIcons.person_fill,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Full Name',
                              style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: TextFormField(
                                controller: name,
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
                    height: 10.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Colors.grey, width: 1)),
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/images/Vector (7).png'),
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
                    height: 10.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Colors.grey, width: 1)),
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/images/Vector (9).png'),
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone',
                              style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: TextFormField(
                                controller: phone,
                                keyboardType: TextInputType.number,
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
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap:() async {
                      var dateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000));
                      dob.text =
                      '${dateTime!.day}-${dateTime.month}-${dateTime.year}';
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/Group 14.png'),
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DOB',
                                style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 20,
                                child: TextFormField(
                                  controller: dob,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                    hintText: 'Enter here',
                                    contentPadding: EdgeInsets.symmetric(vertical: 2),
                                    enabled: false,
                                    hintStyle: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Colors.grey, width: 1)),
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/images/Group 14.png'),
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nationality',
                              style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: TextFormField(
                                controller: nationality,
                                keyboardType: TextInputType.text,
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
                    height: 10.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Colors.grey, width: 1)),
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/images/Vector (10).png'),
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Passport ID',
                              style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: TextFormField(
                                controller: passportId,
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
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var dateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000));
                      passportExpiryDate.text =
                      '${dateTime!.day}-${dateTime.month}-${dateTime.year}';
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/Vector (10).png'),
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Passport Expiry Date',
                                style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 20,
                                child: TextFormField(
                                  controller: passportExpiryDate,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                    hintText: 'Enter here',
                                    enabled: false,
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
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Colors.grey, width: 1)),
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/images/Vector (10).png'),
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pass Type',
                              style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: TextFormField(
                                controller: passType,
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
                    height: 10.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Colors.grey, width: 1)),
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/images/Vector (10).png'),
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pass Id',
                              style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: TextFormField(
                                controller: passId,
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
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var dateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000));
                      passExpiryDate.text =
                      '${dateTime!.day}-${dateTime.month}-${dateTime.year}';
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/Vector (10).png'),
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pass Expiry Date',
                                style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 20,
                                child: TextFormField(
                                  controller: passExpiryDate,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                    hintText: 'Enter here',
                                    enabled: false,
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
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Colors.grey, width: 1)),
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/images/lock.png'),
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: TextFormField(
                                controller: password,
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
                    height: 10.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Colors.grey, width: 1)),
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/images/lock.png'),
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm Password',
                              style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: TextFormField(
                                controller: confirmPassword,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                  hintText: 'Enter here',
                                  contentPadding: EdgeInsets.symmetric(vertical: 2),
                                  hintStyle: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: accept,
                        onChanged: (val) {
                          setState(() {
                            accept = val!;
                          });
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          'I accept the Terms & Conditions an Privacy Policy.',
                          style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (name.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter name')));
                      } else if (email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter email')));
                      } else if (phone.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter phone')));
                      } else if (dob.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter age')));
                      } else if (passportId.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter passport Id')));
                      }else if (passportExpiryDate.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter passport expiry date')));
                      }else if (passType.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter pass type')));
                      }else if (passId.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter pass Id')));
                      } else if (passExpiryDate.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter pass expiry date')));
                      }else if (password.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter password')));
                      } else if (confirmPassword.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please confirm password')));
                      } else if (password.text != confirmPassword.text) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password doesn\'t match')));
                      } else if (!accept) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please accept terms & conditions')));
                      } else {
                        var data = {
                          'name': name.text,
                          'email': email.text,
                          'phone': phone.text,
                          'dob': dob.text,
                          'nationality': nationality.text,
                          'passportId': passportId.text,
                          'passportExp': passportExpiryDate.text,
                          'passType': passType.text,
                          'passId': passId.text,
                          'passExp': passExpiryDate.text,
                          'isVerify': false,
                          'profilePicture': 'https://i.pravatar.cc/150?img=3',
                          'createdAt': todayDate,
                          'paymentHistory': []
                        };

                        await signUp(context, data);
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
                          'Next',
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
      ) : LoadingWidget(context),
    );
  }

  signUp(ctx, data) async {
    var user = Provider.of<UserProvider>(ctx, listen: false);

    user.setIsLoading(true);

    await user.signUpUser(data, password.text.trim()).then((value) {
      user.setIsLoading(false);

      if (value['success'] == true) {
        showToast('Registered successfully!');

        Navigator.push(
            ctx,MaterialPageRoute(builder: (context) => EmailConfirmPage()));
      } else {
        showToast(errorTxt);
      }
    }).catchError((e) {
      user.setIsLoading(false);
      print(e);

      // if (e.code == '[firebase_auth/weak-password]') {
      //   showToast('Password should be at least 6 characters');
      // }
      // else if (e.code == 'invalid-email') {
      //   showToast('Invalid email! enter correct email.');
      // }
      // else if (e.code == 'wrong-password') {
      //   showToast('Your password is incorrect.');
      // }
      // else {
        showToast(errorTxt);
      // }
    });
  }
}
