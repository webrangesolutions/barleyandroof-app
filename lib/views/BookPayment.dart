import 'dart:io';

import 'package:barleryroof/Views/TenancyAgreementPage.dart';
import 'package:barleryroof/providers/unit_provider.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Views/BottomBar.dart';
import '../constant.dart';

class BookPaymentPage extends StatefulWidget {
  Map<String, dynamic>? data;

  BookPaymentPage({Key? key, this.data}) : super(key: key);

  @override
  State<BookPaymentPage> createState() => _BookPaymentPageState();
}

class _BookPaymentPageState extends State<BookPaymentPage> {
  var status = true;
  var status1 = true;
  var status2 = true;
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController bname = new TextEditingController();
  TextEditingController bcode = new TextEditingController();
  TextEditingController anumber = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var units = Provider.of<UnitProvider>(context);

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
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                        )
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
                          GestureDetector(
                            onTap: () {
                              print(widget.data);
                            },
                            child: Text(
                              'Payment Details',
                              style: GoogleFonts.nunitoSans(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Step 1 of 3',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.all(10.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Booking Deposit ',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '\$ ${units.unitList.where((u) => u.uid == widget.data!['unitId']).first.rooms!.where((r) => r['uid'] == widget.data!['roomId']).first['price']}', //price
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Security Deposit ',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '\$ ${units.unitList.where((u) => u.uid == widget.data!['unitId']).first.rooms!.where((r) => r['uid'] == widget.data!['roomId']).first['price']}', //price
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Admin Fee ',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '\$ ${units.unitList.where((u) => u.uid == widget.data!['unitId']).first.securityDeposit}', //
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Payment ',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '\$ ${double.parse(units.unitList.where((u) => u.uid == widget.data!['unitId']).first.rooms!.where((r) => r['uid'] == widget.data!['roomId']).first['price']) + double.parse(units.unitList.where((u) => u.uid == widget.data!['unitId']).first.rooms!.where((r) => r['uid'] == widget.data!['roomId']).first['price']) + double.parse(units.unitList.where((u) => u.uid == widget.data!['unitId']).first.securityDeposit!)}', //\$${widget.data!['price'] / 100 * 10 + widget.data!['price']}
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Payment Details',
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      // SizedBox(
                      //   height: 15.h,
                      // ),
                      // Text(
                      //   'Online Payment Instructions',
                      //   style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w500),
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
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
                                  'Account Name',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      enabled: false,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: 'BARLEY AND ROOF PTE. LTD',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
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
                                  'Bank Name',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: 'UOB BANK',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
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
                                  'Swift Code',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      enabled: false,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: 'UOVBSGSG',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
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
                                  'Bank Account No.',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 20,
                                  child: TextFormField(
                                    controller: anumber,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: '4213155851',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
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
                                  'Bank Code',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      enabled: false,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: '7375',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
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
                                  'Branch Code',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      enabled: false,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: '494',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.data!.addAll({
                            'payment':
                                '${double.parse(units.unitList.where((u) => u.uid == widget.data!['unitId']).first.rooms!.where((r) => r['uid'] == widget.data!['roomId']).first['price']) + double.parse(units.unitList.where((u) => u.uid == widget.data!['unitId']).first.rooms!.where((r) => r['uid'] == widget.data!['roomId']).first['price']) + double.parse(units.unitList.where((u) => u.uid == widget.data!['unitId']).first.securityDeposit!)}'
                                    .toString(),
                          });

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  PaymentDetail(data: widget.data)));
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
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
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
}

class PaymentDetail extends StatefulWidget {
  PaymentDetail({Key? key, this.data}) : super(key: key);

  Map<String, dynamic>? data;

  @override
  State<PaymentDetail> createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  var status = true;
  var status1 = true;
  var status2 = true;
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController bname = new TextEditingController();
  TextEditingController bcode = new TextEditingController();
  TextEditingController anumber = new TextEditingController();

  FilePickerResult? result;

  bool isLater = false;

  @override
  Widget build(BuildContext context) {
    var units = Provider.of<UnitProvider>(context);
    var user = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SizedBox(
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
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                        )
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
                          GestureDetector(
                            onTap: () {
                              print(widget.data);
                            },
                            child: Text(
                              'Details Confirmation',
                              style: GoogleFonts.nunitoSans(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Payment Details Confirmation',
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      // SizedBox(
                      //   height: 15.h,
                      // ),
                      // Text(
                      //   'Online Payment Instructions',
                      //   style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w500),
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
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
                                  'Project Name',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText:
                                          '${units.unitList.where((u) => u.uid == widget.data!['unitId']).first.title}',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
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
                                  'Room',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      enabled: false,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText:
                                          '${units.unitList.where((u) => u.uid == widget.data!['unitId']).first.rooms!.where((r) => r['uid'] == widget.data!['roomId']).first['title']}',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
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
                                  'Tenancy Start Date',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: '${widget.data!['startDate']}',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
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
                                  'Tenancy End Date',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      enabled: false,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: '${widget.data!['endDate']}',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
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
                                  'Length of Stay',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: '${widget.data!['period']}',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
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
                                  'Rent',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: '\$ ${widget.data!['payment']}',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var msg = await FilePicker.platform
                              .pickFiles(type: FileType.image);

                          setState(() {
                            result = msg;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 50.h,
                          margin: EdgeInsets.only(top: 30.h),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  AssetImage('assets/images/map.png'),
                                  size: 30,
                                  color: Colors.black,
                                ),
                                Text(
                                  ' Select Payment Receipt',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      result != null && result!.files.length > 0
                          ? Container(
                              margin: EdgeInsets.only(top: 20.h),
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 5,
                                children: result!.files.map((file) {
                                  return Container(
                                    height: 120.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        image: DecorationImage(
                                            image: FileImage(File(file.path!)),
                                            fit: BoxFit.cover)),
                                  );
                                }).toList(),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                       GestureDetector(
                        onTap: () {
                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Please select payment receipt')));
                          } else {
                            user.setIsLoading(true);

                            result!.files.forEach((f) async {
                              var id = getRandomString(5);
                              var data = {
                                'id': id,
                                'fileName': DateTime.now().microsecondsSinceEpoch.toString(),
                                'file': File(f.path!),
                              };

                              await units
                                  .postUnitStorage('bookings/receipt', data)
                                  .then((url) {
                                widget.data!.addAll({'receipt': url});
                              });
                            });

                            Future.delayed(Duration(seconds: 3)).then((value) {
                              user.setIsLoading(false);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      TenancyAgreementPage(data: widget.data)));
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
                              user.isLoading == false ? 'Next' : 'Loading...',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLater == false ?
                          TextButton(
                              onPressed: () async {
                                setState(() {
                                  isLater = true;
                                });

                                var id = getRandomString(28);
                                widget.data!.addAll({
                                  'receipt': '',
                                  'agreement': '',
                                  'uid': id,
                                  'bookBy': user.user!.uid,
                                  'step': 0,
                                  'status': 'Payment Not Done',
                                  'reason': '',
                                  'paymentDate': '',
                                });

                                await postBooking(widget.data);
                              },
                              child: Text(
                                'I will upload later',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18.sp,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600),
                              )) : CircularProgressIndicator(),
                        ],
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

  postBooking(data) async {
    var user = Provider.of<UserProvider>(context, listen: false);
    var units = Provider.of<UnitProvider>(context, listen: false);

    await units.postUnitBooking(data).then((value) async {
      setState(() {
        isLater = false;
      });

      if (value['success'] == true) {
        showToast('Submitted successfully');
        finalDialog();
      } else {
        showToast('Submission failed !');
      }
    }).catchError((e) {
      setState(() {
        isLater = false;
      });
      showToast('Submission failed !');
    });
  }

  finalDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Container(
                  height: 350.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 350.h,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Booking Saved',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Please make payment based on the payment detail. After payment is made, please continue this booking.',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => BottomBarPage()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 50.h,
                                child: Center(
                                  child: Text(
                                    'Done',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 10)
                        ]),
                    padding: EdgeInsets.all(10.r),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 60.r,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
