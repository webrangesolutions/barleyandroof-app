import 'dart:io';

import 'package:barleryroof/constant.dart';
import 'package:barleryroof/providers/unit_provider.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class AddUnitPage extends StatefulWidget {
  const AddUnitPage({Key? key}) : super(key: key);

  @override
  State<AddUnitPage> createState() => _AddUnitPageState();
}

class _AddUnitPageState extends State<AddUnitPage> {
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

  TextEditingController noOfRoomsController = TextEditingController();

  var noOfRooms = 1;

  FilePickerResult? result;

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
                          'Add Unit',
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
                        GestureDetector(
                          onTap: () async {
                            var dateTime = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000));
                            leaseStartDate.text =
                            '${dateTime!.day}-${dateTime.month}-${dateTime.year}';
                          },
                          child: Container(
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
                                          enabled: false,
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
                        GestureDetector(
                          onTap: () async {
                            var dateTime = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000));
                            leaseEndDate.text =
                            '${dateTime!.day}-${dateTime.month}-${dateTime.year}';
                          },
                          child: Container(
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
                                          enabled: false,
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
                        GestureDetector(
                          onTap: () async {
                            var msg = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddRoom()));

                            if (msg != null) {
                              setState(() {
                                rooms.add(msg);
                              });
                            }
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
                                          hintText: '${rooms.length}',
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
                            if (title.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please enter name')));
                            } else if (buildingName.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Please enter building name')));
                            } else if (bik.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please enter bik')));
                            } else if (street.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Please enter street name')));
                            } else if (unit.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Please enter unit no.')));
                            } else if (postalCode.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Please enter postal code')));
                            } else if (rentalPrice.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Please enter rental price')));
                            } else if (leaseStartDate.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Please enter lease start date')));
                            } else if (leaseEndDate.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Please enter lease end date')));
                            } else if (leasePeriod.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Please enter lease period')));
                            } else if (rentalDay.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Please enter rental day')));
                            } else if (securityDeposit.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Please enter security deposit')));
                            } else if (whatsapp.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Please enter whatsapp')));
                            } else if (remark.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Please enter remark')));
                            } else if (result!.files.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Please pick images')));
                            } else {
                              await addUnit();
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
                                'Submit',
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

  addUnit() async {
    var user = Provider.of<UserProvider>(context, listen: false);
    var units = Provider.of<UnitProvider>(context, listen: false);

    user.setIsLoading(true);

    await postStorage();

    if (images.length < 1) {
      Future.delayed(Duration(seconds: 3)).then((value) async {
        var id = getRandomString(28);
        var data = {
          'uid': id,
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
          "rooms": rooms,
          'images': images,
          'tenants': []
        };
        print(data);

        await units.postUnit(data).then((value) {
          user.setIsLoading(false);
          if (value['success'] == true) {
            showToast('Unit added successfully');
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
      var id = getRandomString(28);
      var data = {
        'uid': id,
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
        "rooms": rooms,
        'images': images,
        'tenants': []
      };
      print(data);

      await units.postUnit(data).then((value) {
        user.setIsLoading(false);
        if (value['success'] == true) {
          showToast('Unit added successfully');
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

class AddRoom extends StatefulWidget {
  const AddRoom({Key? key}) : super(key: key);

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
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

                              setState(() {
                                isLoading = false;
                              });

                              Navigator.pop(context, rooms);
                            });
                          }
                          else {
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

                            setState(() {
                              isLoading = false;
                            });

                            Navigator.pop(context, rooms);
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
