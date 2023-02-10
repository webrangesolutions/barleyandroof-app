import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  var status=true;
  var status1=true;
  var status2=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        height: MediaQuery.of(context).size.height ,
        width: MediaQuery.of(context).size.width,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_outlined,color: Colors.black,size: 30,)),
                      Text(
                        ' Notifications',
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.74,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          ' Today Notifications',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.all(10.h),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Icon(Icons.notifications,color: Colors.black,size: 30,),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Text(
                                  ' Payment Due for this month',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.red,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Text(
                                  ' Please pay the rent for this month',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
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
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.all(10.h),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Icon(Icons.notifications,color: Colors.black,size: 30,),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Text(
                                  ' Maintainnense will be done this sunday (12 jan 2023)',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Text(
                                  ' Please pay the rent for this month',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
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
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.all(10.h),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Icon(Icons.notifications,color: Colors.black,size: 30,),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Text(
                                  ' Payment Due for this month',
                                  style: GoogleFonts.nunitoSans(
                                      color:  Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Text(
                                  ' Please pay the rent for this month',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          ' Previous Notifications',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.all(10.h),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Icon(Icons.notifications,color: Colors.black,size: 30,),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Text(
                                  ' Maintainnense will be done this sunday (12 jan 2023)',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Text(
                                  ' Please pay the rent for this month',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
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
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.all(10.h),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Icon(Icons.notifications,color: Colors.black,size: 30,),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Text(
                                  ' Payment Due for this month',
                                  style: GoogleFonts.nunitoSans(
                                      color:  Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: Text(
                                  ' Please pay the rent for this month',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
