import 'package:barleryroof/Views/RequestApplyPage.dart';
import 'package:barleryroof/providers/unit_provider.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/booking_model.dart';

class AdminTenantDetailsPage extends StatefulWidget {
  BookingModel? tenant;

  AdminTenantDetailsPage({super.key, this.tenant});

  @override
  State<AdminTenantDetailsPage> createState() => _AdminTenantDetailsPageState();
}

class _AdminTenantDetailsPageState extends State<AdminTenantDetailsPage> {
  var step = 1;
  var status = "";
  var workpass_viewed = false;
  var passport_viewed = false;

  Timestamp? booking_date_applied = Timestamp.now();

  final reasonTxt = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var unit = Provider.of<UnitProvider>(context);

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
                            onTap: () {},
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.transparent,
                            ))
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
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 150,
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 100,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.all(10.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${user.usersList.where((u) => u.uid == widget.tenant!.bookBy).first.name}',
                                              style: GoogleFonts.nunitoSans(
                                                  color: Colors.black,
                                                  fontSize: 25.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    left: 10,
                                    right: 10,
                                    child: Container(
                                      height: 70.h,
                                      width: 70.h,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                '${user.usersList.where((u) => u.uid == widget.tenant!.bookBy).first.profilePicture}'),
                                          )),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Passport No.',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '${user.usersList.where((u) => u.uid == widget.tenant!.bookBy).first.passportId}',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Passport Expiry',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '${user.usersList.where((u) => u.uid == widget.tenant!.bookBy).first.passExpiry}',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Payment Receipt',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.network(
                                  widget.tenant!.receipt!,
                                  height: 140.h,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Tenant Flow',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
                                )
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'New Booking',
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.68,
                                    child: Text(
                                      "Submitted on " +
                                          widget.tenant!.startDate!,
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
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
                                      child: Icon(
                                        widget.tenant!.step! >= 1
                                            ? Icons.check_circle
                                            : Icons.circle,
                                        color: widget.tenant!.step! >= 1
                                            ? Colors.green
                                            : Colors.black,
                                        size: 30.r,
                                      ),
                                    ),
                                    Container(
                                      height: 150,
                                      child: DottedLine(
                                        direction: Axis.vertical,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
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
                                      child: Icon(
                                        widget.tenant!.step! >= 2
                                            ? Icons.check_circle
                                            : Icons.circle,
                                        color: widget.tenant!.step! >= 2
                                            ? Colors.green
                                            : Colors.black,
                                        size: 30.r,
                                      ),
                                    ),
                                    Container(
                                      height: 150,
                                      child: DottedLine(
                                        direction: Axis.vertical,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
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
                                      'Payment Done',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
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
                                      child: Icon(
                                        widget.tenant!.step! >= 3
                                            ? Icons.check_circle
                                            : Icons.circle,
                                        color: widget.tenant!.step! >= 3
                                            ? Colors.green
                                            : Colors.black,
                                        size: 30.r,
                                      ),
                                    ),
                                    Container(
                                      height: 150,
                                      child: DottedLine(
                                        direction: Axis.vertical,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
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
                                      'User Documents',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImagesScreen(
                                                      Images: widget
                                                          .tenant!.workPass,
                                                    ),
                                                  ),
                                                );
                                                setState(() {
                                                  workpass_viewed = true;
                                                });

                                                if (workpass_viewed &&
                                                    passport_viewed) {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Bookings')
                                                      .doc(widget.tenant!.uid)
                                                      .update({'step': 3});

                                                  await unit.fetchAllBookings();
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                height: 50.h,
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ImageIcon(AssetImage(
                                                          'assets/images/work.png')),
                                                      Text(
                                                        ' Work Pass',
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImagesScreen(
                                                      Images: widget
                                                          .tenant!.passport,
                                                    ),
                                                  ),
                                                );

                                                setState(() {
                                                  passport_viewed = true;
                                                });

                                                if (workpass_viewed &&
                                                    passport_viewed) {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Bookings')
                                                      .doc(widget.tenant!.uid)
                                                      .update({'step': 3});

                                                  await unit.fetchAllBookings();
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                height: 50.h,
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ImageIcon(AssetImage(
                                                          'assets/images/Frame (5).png')),
                                                      Text(
                                                        'Passport',
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
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
                                      child: Icon(
                                        widget.tenant!.step! >= 4
                                            ? Icons.check_circle
                                            : Icons.circle,
                                        color: widget.tenant!.step! >= 4
                                            ? Colors.green
                                            : Colors.black,
                                        size: 30.r,
                                      ),
                                    ),
                                    Container(
                                      height: 150,
                                      child: DottedLine(
                                        direction: Axis.vertical,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
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
                                      'Full Payment',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    // accept payment button
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  isLoading = true;
                                                });

                                                await FirebaseFirestore.instance
                                                    .collection('Bookings')
                                                    .doc(widget.tenant!.uid)
                                                    .update({'step': 4}).then(
                                                        (value) async {
                                                  await unit.fetchAllBookings();

                                                  setState(() {
                                                    isLoading = false;
                                                  });

                                                  Navigator.pop(context);
                                                }).catchError((e) {
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                height: 50.h,
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ImageIcon(AssetImage(
                                                          'assets/images/Group 754.png')),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        isLoading == false ? 'Mark Payment as Paid' : 'Loading...',
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )

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
                                      child: Icon(
                                        widget.tenant!.step! >= 5
                                            ? Icons.check_circle
                                            : Icons.circle,
                                        color: widget.tenant!.step! == 5
                                            ? Colors.green
                                            : Colors.black,
                                        size: 30.r,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
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
                                      'Booking Done',
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
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            isLoading == false
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Reason for Rejection'),
                                                    content: TextField(
                                                      controller: reasonTxt,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Enter Reason',
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          if (reasonTxt
                                                              .text.isEmpty) {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    'Please enter a reason');
                                                            return;
                                                          }

                                                          setState(() {
                                                            isLoading = true;
                                                          });

                                                          await unit
                                                              .updateBooking(
                                                                  widget.tenant!
                                                                      .uid,
                                                                  {
                                                                'status':
                                                                    'Rejected',
                                                                'reason':
                                                                    reasonTxt
                                                                        .text,
                                                              }).then(
                                                                  (value) async {
                                                            await unit
                                                                .fetchAllUnits();
                                                            await unit
                                                                .fetchAllBookings();

                                                            setState(() {
                                                              isLoading = false;
                                                            });

                                                            Navigator.pop(
                                                                context);
                                                          }).catchError((e) {
                                                            setState(() {
                                                              isLoading = false;
                                                            });
                                                          });

                                                          if (user.usersList
                                                                  .where((u) =>
                                                                      u.uid ==
                                                                      widget
                                                                          .tenant!
                                                                          .bookBy)
                                                                  .length >
                                                              0) {
                                                            user.updateUser(
                                                                user.usersList
                                                                    .where((u) =>
                                                                        u.uid ==
                                                                        widget
                                                                            .tenant!
                                                                            .bookBy)
                                                                    .first
                                                                    .uid,
                                                                {
                                                                  'paymentHistory':
                                                                      FieldValue
                                                                          .arrayRemove([
                                                                    user.usersList
                                                                        .where((u) =>
                                                                            u.uid ==
                                                                            widget
                                                                                .tenant!.bookBy)
                                                                        .first
                                                                        .paymentHistory!
                                                                        .where((p) =>
                                                                            p['bookingId'] ==
                                                                            widget.tenant!.uid)
                                                                        .first
                                                                  ])
                                                                });
                                                          }

                                                          if (unit.unitList
                                                                  .where((u) =>
                                                                      u.uid ==
                                                                      widget
                                                                          .tenant!
                                                                          .unitId)
                                                                  .length >
                                                              0) {
                                                            unit.updateUnit(
                                                                unit.unitList
                                                                    .where((u) =>
                                                                        u.uid ==
                                                                        widget
                                                                            .tenant!
                                                                            .unitId)
                                                                    .first
                                                                    .uid,
                                                                {
                                                                  'tenants':
                                                                      FieldValue
                                                                          .arrayRemove([
                                                                    unit.unitList
                                                                        .where((u) =>
                                                                            u.uid ==
                                                                            widget
                                                                                .tenant!.unitId)
                                                                        .first
                                                                        .tenants!
                                                                        .where((t) =>
                                                                            t ==
                                                                            widget.tenant!.bookBy)
                                                                        .first
                                                                  ])
                                                                });
                                                          }
                                                        },
                                                        child: Text('Reject'),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.deepOrange,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            height: 50.h,
                                            child: Center(
                                              child: Text(
                                                'Reject Request',
                                                style: GoogleFonts.nunitoSans(
                                                    color: Colors.white,
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            var id = getRandomString(10);

                                            setState(() {
                                              isLoading = true;
                                            });

                                            // await unit
                                            //     .updateUnit(widget.tenant!.unitId, {
                                            // 'tenants': FieldValue.arrayUnion([
                                            // {
                                            // 'uid': id,
                                            // 'userId': widget.tenant!.bookBy,
                                            // 'roomId': widget.tenant!.roomId,
                                            // 'period': widget.tenant!.period,
                                            // 'price': widget.tenant!.payment,
                                            // }
                                            // ])

                                            await unit.updateUnit(
                                                widget.tenant!.unitId, {
                                              'tenants': FieldValue.arrayUnion(
                                                  [widget.tenant!.bookBy])
                                            }).then((value) async {
                                              await unit.updateBooking(
                                                  widget.tenant!.uid, {
                                                'step': 5,
                                                'status': 'Accepted'
                                              }).then((value) async {
                                                await unit.fetchAllBookings();
                                                await unit.fetchAllUnits();

                                                setState(() {
                                                  isLoading = false;
                                                });

                                                Navigator.pop(context);
                                              });
                                            }).catchError((e) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });

                                            // await FirebaseFirestore.instance
                                            //     .collection('Units')
                                            //     .doc(widget.tenant!.unitId)
                                            //     .collection('Tenants')
                                            //     .doc(snapshot.data!.data()!["id"])
                                            //     .set({
                                            //   'unit_price': await FirebaseFirestore.instance
                                            //       .collection('Units')
                                            //       .doc(snapshot.data!.data()!["roomId"])
                                            //       .get()
                                            //       .then((value) => value.data()!["price"]),
                                            //   'period': snapshot.data!.data()!["period"],
                                            //   'tenantid': snapshot.data!.data()!["id"],
                                            //   'roomid': snapshot.data!.data()!["roomId"],
                                            //   // 'bookingid': widget.id,
                                            // }).then((value) {
                                            //   FirebaseFirestore.instance.collection('Bookings').doc(widget.tenant!.uid).update({
                                            //     'status': 'Accepted',
                                            //   });
                                            // });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            height: 50.h,
                                            child: Center(
                                              child: Text(
                                                'Accept Tenancy',
                                                style: GoogleFonts.nunitoSans(
                                                    color: Colors.black,
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : CircularProgressIndicator()
                          ],
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagesScreen extends StatefulWidget {
  final Images;

  const ImagesScreen({Key? key, this.Images}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(
        msg: "Swipe left and right to view all images",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: false,
              initialPage: 0,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: widget.Images.map<Widget>((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Image.network(
                      i,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
