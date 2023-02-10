import 'package:barleryroof/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'NotificationsPage.dart';
import 'RequestAService.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.19,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '${user.user!.profilePicture}'),
                                      fit: BoxFit.fill)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user.user!.name}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Good Morning!',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.grey,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => NotificationsPage()));
                          },
                          child: Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.notifications,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        )
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
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            ' My Current Requests',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      user.requestsList
                                  .where((r) => (r.createdById == user.user!.uid) && (r.closed == false))
                                  .length >
                              0
                          ? Container(
                              // height: 250,
                              constraints: BoxConstraints(
                                maxHeight: 250.h,
                                minHeight: 100.h
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.all(0),
                              child: ListView.builder(
                                  itemCount: user.requestsList
                                      .where((r) => (r.createdById == user.user!.uid) && (r.closed == false))
                                      .length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.all(0),
                                  itemBuilder: (context, index) {
                                    var x = user.requestsList
                                        .where((r) => (r.createdById == user.user!.uid) && (r.closed == false)).toList()[index];

                                    return user.requestsList
                                        .where((r) => (r.createdById == user.user!.uid) && (r.closed == false))
                                        .length > 0
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          RequestAService(request: x,)));
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                                              margin: EdgeInsets.only(top: 5.h, bottom: 5.h, right: 10.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                          child: Text(
                                                            '${x.title}',
                                                            style: GoogleFonts.nunitoSans(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        x.step ==
                                                                    5 &&
                                                                x
                                                                        .closed ==
                                                                    true
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          10.r),
                                                                  color: Colors
                                                                      .green
                                                                      .shade50,
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5
                                                                            .w),
                                                                child: Text(
                                                                  'Completed',
                                                                  style: GoogleFonts.nunitoSans(
                                                                      color: Colors
                                                                          .green
                                                                          .shade900,
                                                                      fontSize: 12
                                                                          .sp,
                                                                      fontWeight:
                                                                          FontWeight.w500),
                                                                ),
                                                              )
                                                            : x.step !=
                                                                        5 &&
                                                                    x.closed ==
                                                                        false
                                                                ? Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(10.r),
                                                                      color: Colors
                                                                          .yellow
                                                                          .shade50,
                                                                    ),
                                                                    padding: EdgeInsets
                                                                        .all(5
                                                                            .w),
                                                                    child:
                                                                        Text(
                                                                      'In Progress',
                                                                      style: GoogleFonts.nunitoSans(
                                                                          color:
                                                                              Colors.yellow.shade700,
                                                                          fontSize: 12.sp,
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                                  )
                                                                : x.step !=
                                                                            5 &&
                                                                        x.closed ==
                                                                            true
                                                                    ? Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.r),
                                                                          color:
                                                                              Colors.red.shade50,
                                                                        ),
                                                                        padding:
                                                                            EdgeInsets.all(5.w),
                                                                        child:
                                                                            Text(
                                                                          'Not Completed',
                                                                          style: GoogleFonts.nunitoSans(
                                                                              color: Colors.red.shade900,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Text(
                                                    '${x.step} of 5 (${x.step == 1 ? 'Request Submitted' : x.step == 2 ? 'Admin Looking at the matter' : x.step == 3 ? 'Admin initiated the process' : x.step == 4 ? 'Under Process' : 'Request Resolved'})',
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: GoogleFonts
                                                        .nunitoSans(
                                                            color:
                                                                Colors.grey,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        0.8,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        x
                                                                    .step! >=
                                                                1
                                                            ? Icon(
                                                                Icons
                                                                    .circle,
                                                                color: Colors
                                                                    .green,
                                                                size: 15.r,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .circle,
                                                                color: Colors
                                                                    .black,
                                                                size: 15.r,
                                                              ),
                                                        Expanded(
                                                            child:
                                                                DottedLine()),
                                                        x
                                                                    .step! >=
                                                                2
                                                            ? Icon(
                                                                Icons
                                                                    .circle,
                                                                color: Colors
                                                                    .green,
                                                                size: 15.r,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .circle,
                                                                color: Colors
                                                                    .black,
                                                                size: 15.r,
                                                              ),
                                                        Expanded(
                                                            child:
                                                                DottedLine()),
                                                       x
                                                                    .step! >=
                                                                3
                                                            ? Icon(
                                                                Icons
                                                                    .circle,
                                                                color: Colors
                                                                    .green,
                                                                size: 15.r,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .circle,
                                                                color: Colors
                                                                    .black,
                                                                size: 15.r,
                                                              ),
                                                        Expanded(
                                                            child:
                                                                DottedLine()),
                                                        x
                                                                    .step! >=
                                                                4
                                                            ? Icon(
                                                                Icons
                                                                    .circle,
                                                                color: Colors
                                                                    .green,
                                                                size: 15.r,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .circle,
                                                                color: Colors
                                                                    .black,
                                                                size: 15.r,
                                                              ),
                                                        Expanded(
                                                            child:
                                                                DottedLine()),
                                                       x
                                                                    .step! >=
                                                                5
                                                            ? Icon(
                                                                Icons
                                                                    .circle,
                                                                color: Colors
                                                                    .green,
                                                                size: 15.r,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .circle,
                                                                color: Colors
                                                                    .black,
                                                                size: 15.r,
                                                              ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container();
                                  }),
                            )
                          : Container(
                              height: 20,
                              child: Text('No Requests Yet !'),
                            ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            ' Previous Requests',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      user.requestsList
                          .where((r) => (r.createdById == user.user!.uid) && (r.closed == true))
                          .length >
                          0 ?
                      ListView.builder(
                          itemCount: user.requestsList
                              .where((r) => (r.createdById == user.user!.uid) && (r.closed == true))
                              .length,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var x = user.requestsList
                                .where((r) => (r.createdById == user.user!.uid) && (r.closed == true))
                                .toList()[index];

                            return user.requestsList
                                .where((r) => (r.createdById == user.user!.uid) && (r.closed == true)).length > 0
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  RequestAService(request: x,)));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(10.h),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 5.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${x.title}',
                                                  style: GoogleFonts
                                                      .nunitoSans(
                                                          color:
                                                              Colors.black,
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                ),
                                                x
                                                                .step ==
                                                            5 &&
                                                        x
                                                                .closed ==
                                                            true
                                                    ? Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          color: Colors
                                                              .green.shade50,
                                                        ),
                                                        padding:
                                                            EdgeInsets.all(
                                                                5.w),
                                                        child: Text(
                                                          'Completed',
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                                  color: Colors
                                                                      .green
                                                                      .shade900,
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      )
                                                    : x
                                                                    .step !=
                                                                5 &&
                                                            x
                                                                    .closed ==
                                                                false
                                                        ? Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r),
                                                              color: Colors
                                                                  .yellow
                                                                  .shade50,
                                                            ),
                                                            padding:
                                                                EdgeInsets
                                                                    .all(5.w),
                                                            child: Text(
                                                              'In Progress',
                                                              style: GoogleFonts.nunitoSans(
                                                                  color: Colors
                                                                      .yellow
                                                                      .shade700,
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          )
                                                        : x.step !=
                                                                    5 &&
                                                                x
                                                                        .closed ==
                                                                    true
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          10.r),
                                                                  color: Colors
                                                                      .red
                                                                      .shade50,
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5
                                                                            .w),
                                                                child: Text(
                                                                  'Not Completed',
                                                                  style: GoogleFonts.nunitoSans(
                                                                      color: Colors
                                                                          .red
                                                                          .shade900,
                                                                      fontSize: 12
                                                                          .sp,
                                                                      fontWeight:
                                                                          FontWeight.w500),
                                                                ),
                                                              )
                                                            : Container(),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${x.step} of 5 (${x.step == 1 ? 'Request Submitted' : x.step == 2 ? 'Admin Looking at the matter' : x.step == 3 ? 'Admin initiated the process' : x.step == 4 ? 'Under Process' : 'Request Resolved'})',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.nunitoSans(
                                                color: Colors.grey,
                                                fontSize: 12.sp,
                                                fontWeight:
                                                    FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                x
                                                            .step! >=
                                                        1
                                                    ? Icon(
                                                        Icons.circle,
                                                        color: Colors.green,
                                                        size: 15.r,
                                                      )
                                                    : Icon(
                                                        Icons.circle,
                                                        color: Colors.black,
                                                        size: 15.r,
                                                      ),
                                                Expanded(
                                                    child: DottedLine()),
                                               x
                                                            .step! >=
                                                        2
                                                    ? Icon(
                                                        Icons.circle,
                                                        color: Colors.green,
                                                        size: 15.r,
                                                      )
                                                    : Icon(
                                                        Icons.circle,
                                                        color: Colors.black,
                                                        size: 15.r,
                                                      ),
                                                Expanded(
                                                    child: DottedLine()),
                                                x
                                                            .step! >=
                                                        3
                                                    ? Icon(
                                                        Icons.circle,
                                                        color: Colors.green,
                                                        size: 15.r,
                                                      )
                                                    : Icon(
                                                        Icons.circle,
                                                        color: Colors.black,
                                                        size: 15.r,
                                                      ),
                                                Expanded(
                                                    child: DottedLine()),
                                                x
                                                            .step! >=
                                                        4
                                                    ? Icon(
                                                        Icons.circle,
                                                        color: Colors.green,
                                                        size: 15.r,
                                                      )
                                                    : Icon(
                                                        Icons.circle,
                                                        color: Colors.black,
                                                        size: 15.r,
                                                      ),
                                                Expanded(
                                                    child: DottedLine()),
                                                x
                                                            .step! >=
                                                        5
                                                    ? Icon(
                                                        Icons.circle,
                                                        color: Colors.green,
                                                        size: 15.r,
                                                      )
                                                    : Icon(
                                                        Icons.circle,
                                                        color: Colors.black,
                                                        size: 15.r,
                                                      ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container();
                          }) :
                      Container(
                        height: 20,
                        child: Text('No Previous Requests Yet !'),
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
      ),
    );
  }
}
