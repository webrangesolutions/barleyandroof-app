import 'dart:io';

import 'package:barleryroof/Views/BookPayment.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BookRoomPage extends StatefulWidget {
  Map<String, dynamic>? data;

  BookRoomPage({Key? key, this.data}) : super(key: key);

  @override
  State<BookRoomPage> createState() => _BookRoomPageState();
}

class _BookRoomPageState extends State<BookRoomPage> {
  TextEditingController startDate = new TextEditingController();
  TextEditingController endDate = new TextEditingController();
  String sdateTxt = '', edateTxt = '';

  var status = true;
  var status1 = true;
  var status2 = true;
  var workpass;
  var workProg = 0.0;
  var passProg = 0.0;
  var passport;
  var result;
  var result1;
  List PassportList = [];
  List workPassList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.black,
                              size: 30,
                            )),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text(
                                'Book Room',
                                style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.87,
                child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Enter Details',
                                style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 20.sp, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Step 1 of 3',
                                style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  padding: EdgeInsets.all(10.h),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Start of Tenancy Agreement',
                                            style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            height: 20,
                                            child: TextFormField(
                                              controller: startDate,
                                              onTap: () async {
                                                var data = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(3000));
                                                startDate.text = '${data!.day}-${data.month}-${data.year}';
                                                setState(() {
                                                  sdateTxt = data.toString();
                                                });
                                              },
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                                hintText: 'DD MM YYYY',
                                                contentPadding: EdgeInsets.symmetric(vertical: 2),
                                                hintStyle: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '*Max 1 Week',
                                        style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  padding: EdgeInsets.all(10.h),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'End of Tenancy Agreement',
                                            style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            height: 20,
                                            child: TextFormField(
                                              controller: endDate,
                                              onTap: () async {
                                                var data = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(3000));
                                                endDate.text = '${data!.day}-${data.month}-${data.year}';
                                                setState(() {
                                                  edateTxt = data.toString();
                                                });
                                              },
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                                hintText: 'DD MM YYYY',
                                                contentPadding: EdgeInsets.symmetric(vertical: 2),
                                                hintStyle: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '*Max 1 Week',
                                        style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              result1 = await FilePicker.platform.pickFiles(allowMultiple: true);
                              if (result1 != null) {
                                setState(() {});
                                result1.files.forEach((element) async {
                                  await UploadWorkPass(element);
                                });
                                setState(() {});
                                print(workPassList);
                              }
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.all(25.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(Icons.card_membership, size: 40,),
                                        Text('Upload WorkPass/Letter of IPA',
                                          style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 13.sp, fontWeight: FontWeight.w600),)
                                      ],
                                    ),
                                    Visibility(
                                        visible: result1 != null,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 17.w),
                                          child: Column(
                                            children: [
                                              LinearPercentIndicator(
                                                percent: 1,
                                                center: new Text(""),
                                                progressColor: Colors.green,
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              result = await FilePicker.platform.pickFiles(allowMultiple: true);
                              if (result != null) {
                                // setState(() {});
                                result.files.forEach((element) {
                                  UploadPassport(element);
                                });
                                setState(() {});
                              }
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: EdgeInsets.all(25.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Icon(Icons.credit_card, size: 40,),
                                    Text(
                                      'Upload Passport',
                                      style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 13.sp, fontWeight: FontWeight.w600),
                                    ),
                                    Visibility(
                                        visible: result != null,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            LinearPercentIndicator(
                                              percent: 1,
                                              center: new Text(""),
                                              progressColor: Colors.green,
                                            ),
                                          ],
                                        ))
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (startDate.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter Start of Tenancy Agreement')));
                              }else if (endDate.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter End of Tenancy Agreement')));
                              } else if (workPassList.length == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Input Work Pass')));
                              } else if (PassportList.length == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Input Passport')));
                              } else {
                                widget.data!.addAll({
                                  'period': DateTime.parse(edateTxt).difference(DateTime.parse(sdateTxt)).inDays,
                                  'startDate': DateFormat('dd-MM-yyyy').format(DateTime.parse(sdateTxt)),
                                  'endDate': DateFormat('dd-MM-yyyy').format(DateTime.parse(edateTxt)),
                                  'passport': PassportList,
                                  'workPass': workPassList
                                });

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => BookPaymentPage(data: widget.data
                                    )));
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
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  UploadPassport(PlatformFile element) async {
    var ref = await FirebaseStorage.instance.ref().child('bookings/passports').child(element.name);
    var data = await ref.putFile(File(element.path!));
    getUrlPass(data, data);
  }

  UploadWorkPass(PlatformFile element) async {
    var ref = await FirebaseStorage.instance.ref().child('bookings/workpass').child(element.name);
    var data = await ref.putFile(File(element.path!));
    getUrlWork(data, data);
  }

  getUrlPass(taskSnapshot, data) async {
    PassportList.add(await data.ref.getDownloadURL());
  }

  getUrlWork(taskSnapshot, data) async {
    workPassList.add(await data.ref.getDownloadURL());
  }
}
