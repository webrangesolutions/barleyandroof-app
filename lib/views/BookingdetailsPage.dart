import 'package:barleryroof/Views/RequestApplyPage.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

import 'RoomDetailsPage.dart';

class BookingdetailsPage extends StatefulWidget {
  const BookingdetailsPage({Key? key}) : super(key: key);

  @override
  State<BookingdetailsPage> createState() => _BookingdetailsPageState();
}

class _BookingdetailsPageState extends State<BookingdetailsPage> {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_outlined,color: Colors.black,size: 30,)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Text(
                              'Booking Detail',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>RequestApplyPage()));
                          },
                          child: Icon(Icons.add_circle,color: Colors.black,))
                    ],
                  ),
                ],
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.87,
              child: SingleChildScrollView(
                  child: Padding(
                      padding:EdgeInsets.all(20.h),
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
                                    Row(
                                      children: [
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width * 0.6,
                                          child: Text(
                                            'New Booking',
                                            style: GoogleFonts.nunitoSans(
                                                color: Colors.black,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.r),
                                            color: Colors.yellow.shade700,
                                          ),
                                          padding: EdgeInsets.all(5.w),
                                          child: Text(
                                            'In Progress',
                                            style: GoogleFonts.nunitoSans(
                                                color: Colors.white,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.68,
                                      child: Text(
                                        'Submitted on 12 feb 2023',
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.grey,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.check_circle,color: Colors.green,size: 30.r,),
                                  ),
                                  Container(
                                    height: 150,
                                    child: DottedLine(
                                      direction: Axis.vertical,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 10.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Step 1 of 5',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Request Submitted',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.7,
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra ridiculus odio odio turpis velit. Sodales blandit cursus est non. In placerat eget maecenas feugiat sem.',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.check_circle,color: Colors.green,size: 30.r,),
                                  ),
                                  Container(
                                    height: 150,
                                    child: DottedLine(
                                      direction: Axis.vertical,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 10.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Step 2 of 5',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Admin Looking at the mater',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.7,
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra ridiculus odio odio turpis velit. Sodales blandit cursus est non. In placerat eget maecenas feugiat sem.',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.circle,color: Colors.black,size: 30.r,),
                                  ),
                                  Container(
                                    height: 150,
                                    child: DottedLine(
                                      direction: Axis.vertical,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 10.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Step 3 of 5',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Admin initiated the process',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.7,
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra ridiculus odio odio turpis velit. Sodales blandit cursus est non. In placerat eget maecenas feugiat sem.',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.circle,color: Colors.black,size: 30.r,),
                                  ),
                                  Container(
                                    height: 150,
                                    child: DottedLine(
                                      direction: Axis.vertical,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 10.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Step 4 of 5',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Under Process',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width*0.7,
                                  //   child: Text(
                                  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra ridiculus odio odio turpis velit. Sodales blandit cursus est non. In placerat eget maecenas feugiat sem.',
                                  //     style: GoogleFonts.nunitoSans(
                                  //         color: Colors.black,
                                  //         fontSize: 12.sp,
                                  //         fontWeight: FontWeight.w500),
                                  //   ),
                                  // ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.circle,color: Colors.black,size: 30.r,),
                                  ),

                                ],
                              ),
                              SizedBox(width: 10.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Step 5 of 5',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Request Resolved',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width*0.7,
                                  //   child: Text(
                                  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra ridiculus odio odio turpis velit. Sodales blandit cursus est non. In placerat eget maecenas feugiat sem.',
                                  //     style: GoogleFonts.nunitoSans(
                                  //         color: Colors.black,
                                  //         fontSize: 12.sp,
                                  //         fontWeight: FontWeight.w500),
                                  //   ),
                                  // ),
                                ],
                              )
                            ],
                          ),

                        ],
                      )
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
