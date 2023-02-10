import 'dart:io';

import 'package:barleryroof/AdminView/AddUnit.dart';
import 'package:barleryroof/constant.dart';
import 'package:barleryroof/models/unit_model.dart';
import 'package:barleryroof/providers/unit_provider.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class EditUnitPage extends StatefulWidget {
  const EditUnitPage({Key? key, this.unit}) : super(key: key);

  final UnitModel? unit;

  @override
  State<EditUnitPage> createState() => _EditUnitPageState();
}

class _EditUnitPageState extends State<EditUnitPage> {
  String unitStatus = 'Active';
  var rooms = [];

  var wifi = false;
  var parking = false;
  var laundry = false;
  var pool = false;
  var uploading = false;
  List<String> images = [];
  TextEditingController title = new TextEditingController();
  TextEditingController buildingName = new TextEditingController();
  TextEditingController bik = new TextEditingController();
  TextEditingController street = new TextEditingController();
  TextEditingController unit = new TextEditingController();
  TextEditingController postalCode = new TextEditingController();
  TextEditingController rentalPrice = new TextEditingController();
  TextEditingController leaseStartDate = new TextEditingController();
  TextEditingController leaseEndDate = new TextEditingController();
  TextEditingController leasePeriod = new TextEditingController();
  TextEditingController rentalDay = new TextEditingController();
  TextEditingController remark = new TextEditingController();
  TextEditingController securityDeposit = new TextEditingController();
  TextEditingController whatsapp = new TextEditingController();
  TextEditingController status = new TextEditingController();

  FilePickerResult? result;

  @override
  void initState() {
    setState(() {
      title..text = widget.unit!.title!;
      buildingName..text = widget.unit!.building!;
      bik..text = widget.unit!.bik!;
      unit..text = widget.unit!.unit!;
      street..text = widget.unit!.street!;
      postalCode..text = widget.unit!.postalCode!;
      rentalPrice..text = widget.unit!.rentalPrice!;
      leaseStartDate..text = widget.unit!.leaseStartDate!;
      leaseEndDate..text = widget.unit!.leaseEndDate!;
      leasePeriod..text = widget.unit!.leasePeriod!;
      rentalDay..text = widget.unit!.dayRental!;
      remark..text = widget.unit!.remark!;
      securityDeposit..text = widget.unit!.securityDeposit!;
      whatsapp..text = widget.unit!.whatsup!;
      status..text = widget.unit!.status!;

      wifi = widget.unit!.wifi!;
      parking = widget.unit!.parking!;
      laundry = widget.unit!.laundry!;
      pool = widget.unit!.pool!;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: user.isLoading == false
          ? SingleChildScrollView(
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
                          'Edit Unit',
                          style: GoogleFonts.nunitoSans(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Please enter your details',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.title,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Unit Title',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: title,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.title,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Building Name',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: buildingName,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.title,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'BIK',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: bik,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.title,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Street Name',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: street,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.title,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Unit No',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: unit,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.title,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Postal Code',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: postalCode,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.title,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rental Price (to Landlord)',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: rentalPrice,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Lease Start Date',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: leaseStartDate,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Lease End Date',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: leaseEndDate,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Period',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: leasePeriod,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Day of Rental Month',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: rentalDay,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: wifi,
                                  onChanged: (val) {
                                    setState(() {
                                      wifi = val!;
                                    });
                                  },
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: ImageIcon(
                                        AssetImage(
                                            'assets/images/Frame (1).png'),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Free Wifi',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: ImageIcon(
                                        AssetImage(
                                            'assets/images/Frame (2).png'),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Parking',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Checkbox(
                                  value: parking,
                                  onChanged: (val) {
                                    setState(() {
                                      parking = val!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: laundry,
                                  onChanged: (val) {
                                    setState(() {
                                      laundry = val!;
                                    });
                                  },
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: ImageIcon(
                                        AssetImage(
                                            'assets/images/Frame (3).png'),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Laundry',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: ImageIcon(
                                        AssetImage(
                                            'assets/images/Frame (4).png'),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Pool',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Checkbox(
                                  value: pool,
                                  onChanged: (val) {
                                    setState(() {
                                      pool = val!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.description,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Remark',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: TextFormField(
                                      controller: remark,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 2),
                                        hintStyle: GoogleFonts.nunitoSans(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      maxLines: 5,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
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
                                    'Admin Fee',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: securityDeposit,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
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
                                    'Whatsapp agent Phone',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: TextFormField(
                                      controller: whatsapp,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        hintText: 'Enter here',
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
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey, width: 1)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.title,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 20,
                                    child: DropdownButton(
                                      value: unitStatus,
                                      onChanged: (val) {
                                        setState(() {
                                          unitStatus = val!;
                                        });
                                      },
                                      items: ['Active', 'InActive']
                                          .map((v) => DropdownMenuItem(
                                              value: v, child: Text('${v}')))
                                          .toList(),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UnitRooms(
                                          unitRooms: widget.unit!.rooms!,
                                          unitId: widget.unit!.uid,
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            padding: EdgeInsets.all(10.h),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.bed,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'No of Rooms',
                                      style: GoogleFonts.nunitoSans(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: 20,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          enabled: false,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          hintText:
                                              '${widget.unit!.rooms!.length}',
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
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            result = await FilePicker.platform.pickFiles(
                                allowMultiple: true, type: FileType.image);
                            if (result != null) {
                              setState(() {
                                uploading = true;
                              });
                              result!.files.forEach((element) {
                                Upload(element);
                              });
                              setState(() {
                                uploading = false;
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ImageIcon(
                                    AssetImage('assets/images/map.png'),
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    ' Pick Images',
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
                                      height: 80.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          image: DecorationImage(
                                              image:
                                                  FileImage(File(file.path!)),
                                              fit: BoxFit.cover)),
                                    );
                                  }).toList(),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await updateUnit();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50.h,
                            child: Center(
                              child: Text(
                                'Update',
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
                  )
                ],
              ),
            )
          : LoadingWidget(context),
    );
  }

  Upload(PlatformFile element) async {
    var ref =
        await FirebaseStorage.instance.ref().child('units').child(element.name);
    var data = await ref.putFile(File(element.path!));
    images.add(await data.ref.getDownloadURL());
  }

  postStorage() async {
    var unit = Provider.of<UnitProvider>(context, listen: false);
    var user = Provider.of<UserProvider>(context, listen: false);

    if (result != null) {
      result!.files.forEach((f) async {
        var data = {
          'id': user.user!.uid,
          'fileName': File(f.path!.split('/').last),
          'file': File(f.path!),
        };

        await unit.postUnitStorage('units', data).then((url) {
          images.add(url);
        });
      });
    }
  }

  updateUnit() async {
    var user = Provider.of<UserProvider>(context, listen: false);
    var units = Provider.of<UnitProvider>(context, listen: false);

    user.setIsLoading(true);

    if (result == null) {
      var data = {
        'title': title.text,
        'building': buildingName.text,
        'bik': bik.text,
        'street': street.text,
        'unit': unit.text,
        'postalCode': postalCode.text,
        'rentalPrice': rentalPrice.text,
        'leaseStartDate': leaseStartDate.text,
        'leaseEndDate': leaseEndDate.text,
        'leasePeriod': leasePeriod.text,
        'dayRental': rentalDay.text,
        'parking': parking,
        'wifi': wifi,
        'laundry': laundry,
        'pool': pool,
        'remark': remark.text,
        'securityDeposit': securityDeposit.text,
        'whatsapp': whatsapp.text,
        'status': unitStatus,
      };

      await units.updateUnit(widget.unit!.uid, data).then((value) {
        user.setIsLoading(false);
        if (value['success'] == true) {
          showToast('Unit updated successfully');
          Navigator.pop(context);
        } else {
          showToast(errorTxt);
        }
      }).catchError((e) {
        showToast(errorTxt);
        user.setIsLoading(false);
      });
    } else {
      await postStorage();

      if (images.length < 1) {
        Future.delayed(Duration(seconds: 3)).then((value) async {
          widget.unit!.images!.forEach((i) {
            images.add(i);
          });

          var data = {
            'title': title.text,
            'building': buildingName.text,
            'bik': bik.text,
            'street': street.text,
            'unit': unit.text,
            'postalCode': postalCode.text,
            'rentalPrice': rentalPrice.text,
            'leaseStartDate': leaseStartDate.text,
            'leaseEndDate': leaseEndDate.text,
            'leasePeriod': leasePeriod.text,
            'dayRental': rentalDay.text,
            'parking': parking,
            'wifi': wifi,
            'laundry': laundry,
            'pool': pool,
            'remark': remark.text,
            'securityDeposit': securityDeposit.text,
            'whatsapp': whatsapp.text,
            'status': unitStatus,
            'images': images,
          };

          await units.updateUnit(widget.unit!.uid, data).then((value) {
            user.setIsLoading(false);
            if (value['success'] == true) {
              showToast('Unit updated successfully');
              Navigator.pop(context);
            } else {
              showToast(errorTxt);
            }
          }).catchError((e) {
            showToast(errorTxt);
            user.setIsLoading(false);
          });
        });
      } else {
        widget.unit!.images!.forEach((i) {
          images.add(i);
        });

        var data = {
          'title': title.text,
          'building': buildingName.text,
          'bik': bik.text,
          'street': street.text,
          'unit': unit.text,
          'postalCode': postalCode.text,
          'rentalPrice': rentalPrice.text,
          'leaseStartDate': leaseStartDate.text,
          'leaseEndDate': leaseEndDate.text,
          'leasePeriod': leasePeriod.text,
          'dayRental': rentalDay.text,
          'parking': parking,
          'wifi': wifi,
          'laundry': laundry,
          'pool': pool,
          'remark': remark.text,
          'securityDeposit': securityDeposit.text,
          'whatsapp': whatsapp.text,
          'status': unitStatus,
          'images': images,
        };

        await units.updateUnit(widget.unit!.uid, data).then((value) {
          user.setIsLoading(false);
          if (value['success'] == true) {
            showToast('Unit updated successfully');
            Navigator.pop(context);
          } else {
            showToast(errorTxt);
          }
        }).catchError((e) {
          showToast(errorTxt);
          user.setIsLoading(false);
        });
      }
    }
  }
}

class UnitRooms extends StatelessWidget {
  UnitRooms({required this.unitRooms, this.unitId});

  var unitRooms = [];
  final String? unitId;

  @override
  Widget build(BuildContext context) {
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
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddMoreRoom(unitId: unitId!,)));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              unitRooms.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ListView.builder(
                          itemCount: unitRooms.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditRoom(
                                              room: unitRooms[index],
                                              unitId: unitId,
                                            )));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 140.h,
                                            child: ListView.builder(
                                                itemCount: unitRooms[index]
                                                        ['images']
                                                    .length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemBuilder: (ctx, i) {
                                                  return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                unitRooms[index]
                                                                        [
                                                                        'images']
                                                                    [i]))),
                                                  );
                                                }),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${unitRooms[index]['title']}',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                                Text(
                                                  '\$ ${unitRooms[index]['price']}/${unitRooms[index]['priceDetail']}',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        right: 15.w,
                                        top: 10.h,
                                        child: GestureDetector(
                                          onTap: () async {
                                            var unitP = Provider.of<UnitProvider>(context, listen: false);
                                            await unitP.updateUnit(unitId, {'rooms': FieldValue. arrayRemove([unitRooms[index]])});

                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                shape: BoxShape.circle),
                                            padding: EdgeInsets.all(10),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class AddMoreRoom extends StatefulWidget {
  const AddMoreRoom({Key? key, required this.unitId}) : super(key: key);

  final String unitId;

  @override
  State<AddMoreRoom> createState() => _AddMoreRoomState();
}

class _AddMoreRoomState extends State<AddMoreRoom> {
  var rooms = {};

  var perday = false;
  var perhour = false;
  var permonth = true;

  TextEditingController price = new TextEditingController();

  String roomName = 'S1';
  final roomNames = [
    'S1',
    'S2',
    'S3',
    'S4',
    'S5',
    'S6',
    'D1',
    'D2',
    'D3',
    'D4',
    'D5',
    'D6',
    'P1',
    'P2',
    'P3',
    'P4',
    'P5',
    'P6'
  ];

  FilePickerResult? result;
  var imagesList = [];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                      size: 30,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Add Room',
                  style: GoogleFonts.nunitoSans(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'Please enter your details',
                  style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Room Name',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 20,
                                child: DropdownButton(
                                  value: roomName,
                                  onChanged: (val) {
                                    setState(() {
                                      roomName = val!;
                                    });
                                  },
                                  items: roomNames
                                      .map((v) => DropdownMenuItem(
                                      value: v, child: Text('${v}')))
                                      .toList(),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 20,
                                child: TextFormField(
                                  controller: price,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: '\$ 200',
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
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: perhour,
                              onChanged: (val) {
                                setState(() {
                                  perhour = val!;
                                  permonth = false;
                                  perday = false;
                                });
                              },
                            ),
                            Container(
                              child: Text(
                                'Per Hour',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: perday,
                              onChanged: (val) {
                                setState(() {
                                  perhour = false;
                                  permonth = false;
                                  perday = val!;
                                });
                              },
                            ),
                            Container(
                              child: Text(
                                'Per Day',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: permonth,
                              onChanged: (val) {
                                setState(() {
                                  perhour = false;
                                  permonth = val!;
                                  perday = false;
                                });
                              },
                            ),
                            Container(
                              child: Text(
                                'Per Month',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        var msg = await FilePicker.platform.pickFiles(
                            allowMultiple: true, type: FileType.image);

                        print('Room Data ----------------- ${msg}');

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
                        margin: EdgeInsets.only(top: 20.h),
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
                                ' Pick Images',
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
                            height: 80.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                image: DecorationImage(
                                    image: FileImage(File(file.path!)),
                                    fit: BoxFit.cover)),
                          );
                        }).toList(),
                      ),
                    )
                        : Container(),
                    GestureDetector(
                      onTap: () async {
                        if (price.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please enter price')));
                        } else if (result == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please select room images')));
                        } else {
                          var unit =
                          Provider.of<UnitProvider>(context, listen: false);

                          setState(() {
                            isLoading = true;
                          });

                          if (imagesList.isEmpty) {
                            result!.files.forEach((f) async {
                              var id = getRandomString(5);
                              var data = {
                                'id': id,
                                'fileName': DateTime.now().microsecondsSinceEpoch.toString(),
                                'file': File(f.path!),
                              };

                              await unit
                                  .postUnitStorage('units/rooms', data)
                                  .then((url) {
                                imagesList.add(url);
                              });
                            });

                            Future.delayed(Duration(seconds: 3)).then((value) {
                              var id = getRandomString(10);

                              rooms.addAll({
                                'uid': id,
                                'title': roomName,
                                'price': price.text,
                                'priceDetail': perhour == true
                                    ? 'Hour'
                                    : perday == true
                                    ? 'Day'
                                    : 'Month',
                                'images': imagesList
                              });


                              unit.updateUnit(widget.unitId, {'rooms': FieldValue.arrayUnion([rooms])}).then((value) {
                                setState(() {
                                  isLoading = false;
                                });

                                if(value['success'] == true){
                                  showToast('Room added !');
                                }else{
                                  showToast(errorTxt);
                                }

                                Navigator.pop(context);
                              }).catchError((e){
                                setState(() {
                                  isLoading = false;
                                });
                                showToast(errorTxt);
                              });
                            });
                          }
                          else {
                            result!.files.forEach((f) async {
                              var id = getRandomString(5);
                              var data = {
                                'id': id,
                                'fileName': DateTime.now().microsecondsSinceEpoch.toString(),
                                'file': File(f.path!),
                              };

                              await unit
                                  .postUnitStorage('units/rooms', data)
                                  .then((url) {
                                imagesList.add(url);
                              });
                            });

                            var id = getRandomString(10);

                            rooms.addAll({
                              'uid': id,
                              'title': roomName,
                              'price': price.text,
                              'priceDetail': perhour == true
                                  ? 'Hour'
                                  : perday == true
                                  ? 'Day'
                                  : 'Month',
                              'images': imagesList
                            });
                            
                            unit.updateUnit(widget.unitId, {'rooms': FieldValue.arrayUnion([rooms])}).then((value) {
                              setState(() {
                                isLoading = false;
                              });
                              
                              if(value['success'] == true){
                                showToast('Room added !');
                              }else{
                                showToast(errorTxt);
                              }

                              Navigator.pop(context);
                            }).catchError((e){
                              setState(() {
                                isLoading = false;
                              });
                              showToast(errorTxt);
                            });
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50.h,
                        margin: EdgeInsets.only(top: 30),
                        child: Center(
                          child: Text(
                            isLoading == false ? 'Add' : 'Loading...',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditRoom extends StatefulWidget {
  EditRoom({Key? key, required this.room, this.unitId}) : super(key: key);

  var room;
  final String? unitId;

  @override
  State<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  var rooms = {};

  var perday = false;
  var perhour = false;
  var permonth = true;

  TextEditingController price = new TextEditingController();

  String roomName = 'S1';
  final roomNames = [
    'S1',
    'S2',
    'S3',
    'S4',
    'S5',
    'S6',
    'D1',
    'D2',
    'D3',
    'D4',
    'D5',
    'D6',
    'P1',
    'P2',
    'P3',
    'P4',
    'P5',
    'P6'
  ];

  FilePickerResult? result;
  var imagesList = [];

  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      price..text = widget.room['price'];

      roomName = widget.room['title'];

      if (widget.room['priceDetail'].contains('Month')) {
        permonth = true;
      } else if (widget.room['priceDetail'].contains('Day')) {
        perday = true;
      } else {
        perhour = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                      size: 30,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Edit Room',
                  style: GoogleFonts.nunitoSans(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'Please enter your details',
                  style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Room Name',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 20,
                                child: DropdownButton(
                                  value: roomName,
                                  onChanged: (val) {
                                    setState(() {
                                      roomName = val!;
                                    });
                                  },
                                  items: roomNames
                                      .map((v) => DropdownMenuItem(
                                          value: v, child: Text('${v}')))
                                      .toList(),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 20,
                                child: TextFormField(
                                  controller: price,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: 'Enter here',
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
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: perhour,
                              onChanged: (val) {
                                setState(() {
                                  perhour = val!;
                                  permonth = false;
                                  perday = false;
                                });
                              },
                            ),
                            Container(
                              child: Text(
                                'Per Hour',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: perday,
                              onChanged: (val) {
                                setState(() {
                                  perhour = false;
                                  permonth = false;
                                  perday = val!;
                                });
                              },
                            ),
                            Container(
                              child: Text(
                                'Per Day',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: permonth,
                              onChanged: (val) {
                                setState(() {
                                  perhour = false;
                                  permonth = val!;
                                  perday = false;
                                });
                              },
                            ),
                            Container(
                              child: Text(
                                'Per Month',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        var msg = await FilePicker.platform.pickFiles(
                            allowMultiple: true, type: FileType.image);

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
                        margin: EdgeInsets.only(top: 20.h),
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
                                ' Pick Images',
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
                                  height: 80.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      image: DecorationImage(
                                          image: FileImage(File(file.path!)),
                                          fit: BoxFit.cover)),
                                );
                              }).toList(),
                            ),
                          )
                        : Container(),
                    GestureDetector(
                      onTap: () async {
                        var unit =
                            Provider.of<UnitProvider>(context, listen: false);

                        setState(() {
                          isLoading = true;
                        });

                        if (result == null) {
                          await unit.updateUnit(widget.unitId, {
                            'rooms': FieldValue.arrayRemove([widget.room])
                          });

                          var data = {
                            'uid': widget.room['uid'],
                            'title': roomName,
                            'price': price.text,
                            'priceDetail': perhour == true
                                ? 'Hour'
                                : perday == true
                                    ? 'Day'
                                    : 'Month',
                            'images': widget.room['images']
                          };

                          await unit.updateUnit(widget.unitId, {
                            'rooms': FieldValue.arrayUnion([data])
                          });

                          setState(() {
                            isLoading = false;
                          });

                          Navigator.pop(context, rooms);
                        } else {
                          if (imagesList.isEmpty) {
                            result!.files.forEach((f) async {
                              var id = getRandomString(5);
                              var data = {
                                'id': id,
                                'fileName': File(f.path!.split('/').last),
                                'file': File(f.path!),
                              };

                              await unit
                                  .postUnitStorage('units/rooms', data)
                                  .then((url) {
                                imagesList.add(url);
                              });
                            });

                            Future.delayed(Duration(seconds: 3))
                                .then((value) async {
                              widget.room['images'].forEach((i) {
                                imagesList.add(i);
                              });

                              var data = {
                                'uid': widget.room['uid'],
                                'title': roomName,
                                'price': price.text,
                                'priceDetail': perhour == true
                                    ? 'Hour'
                                    : perday == true
                                        ? 'Day'
                                        : 'Month',
                                'images': imagesList
                              };

                              await unit.updateUnit(widget.unitId, {
                                'rooms': FieldValue.arrayRemove([widget.room])
                              });

                              await unit.updateUnit(widget.unitId, {
                                'rooms': FieldValue.arrayUnion([data])
                              });

                              setState(() {
                                isLoading = false;
                              });

                              Navigator.pop(context);
                            });
                          } else {
                            result!.files.forEach((f) async {
                              var id = getRandomString(5);
                              var data = {
                                'id': id,
                                'fileName': File(f.path!.split('/').last),
                                'file': File(f.path!),
                              };

                              await unit
                                  .postUnitStorage('units/rooms', data)
                                  .then((url) {
                                imagesList.add(url);
                              });
                            });

                            widget.room['images'].forEach((i) {
                              imagesList.add(i);
                            });

                            var data = {
                              'uid': widget.room['uid'],
                              'title': roomName,
                              'price': price.text,
                              'priceDetail': perhour == true
                                  ? 'Hour'
                                  : perday == true
                                      ? 'Day'
                                      : 'Month',
                              'images': imagesList
                            };

                            await unit.updateUnit(widget.unitId, {
                              'rooms': FieldValue.arrayRemove([widget.room])
                            });

                            await unit.updateUnit(widget.unitId, {
                              'rooms': FieldValue.arrayUnion([data])
                            });

                            setState(() {
                              isLoading = false;
                            });

                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50.h,
                        margin: EdgeInsets.only(top: 30),
                        child: Center(
                          child: Text(
                            isLoading == false ? 'Update' : 'Loading...',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
