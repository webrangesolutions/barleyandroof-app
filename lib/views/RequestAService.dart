import 'package:barleryroof/Views/RequestApplyPage.dart';
import 'package:barleryroof/constant.dart';
import 'package:barleryroof/models/request_model.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'RoomDetailsPage.dart';

class RequestAService extends StatefulWidget {
  const RequestAService({Key? key, this.request}) : super(key: key);

  final RequestModel? request;

  @override
  State<RequestAService> createState() => _RequestAServiceState();
}

class _RequestAServiceState extends State<RequestAService> {
  var status = true;
  var status1 = true;
  var status2 = true;

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
                                'My Requests',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Container()
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.all(10.h),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              width:
                              MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${widget.request!.title}',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  widget.request!.step ==
                                      5 &&
                                      widget.request!.closed ==
                                          true
                                      ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(
                                          10.r),
                                      color:
                                      Colors.green.shade50,
                                    ),
                                    padding:
                                    EdgeInsets.all(5.w),
                                    child: Text(
                                      'Completed',
                                      style: GoogleFonts
                                          .nunitoSans(
                                          color: Colors
                                              .green
                                              .shade900,
                                          fontSize: 12.sp,
                                          fontWeight:
                                          FontWeight
                                              .w500),
                                    ),
                                  )
                                      : widget.request!.step !=
                                      5 &&
                                      widget.request!.closed ==
                                          false
                                      ? Container(
                                    decoration:
                                    BoxDecoration(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          10.r),
                                      color: Colors
                                          .yellow.shade50,
                                    ),
                                    padding:
                                    EdgeInsets.all(5.w),
                                    child: Text(
                                      'In Progress',
                                      style: GoogleFonts
                                          .nunitoSans(
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
                                      : widget.request!.step !=
                                      5 &&
                                      widget.request!.closed ==
                                          true
                                      ? Container(
                                    decoration:
                                    BoxDecoration(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          10.r),
                                      color: Colors
                                          .red.shade50,
                                    ),
                                    padding:
                                    EdgeInsets.all(
                                        5.w),
                                    child: Text(
                                      'Not Completed',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors
                                              .red
                                              .shade900,
                                          fontSize:
                                          12.sp,
                                          fontWeight:
                                          FontWeight
                                              .w500),
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
                              '${widget.request!.step == 1 ? 'Request Submitted' : widget.request!.step == 2 ? 'Admin Looking at the matter' : widget.request!.step == 3 ? 'Admin initiated the process' : widget.request!.step == 4 ? 'Under Process' : 'Request Resolved'}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
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
                                child:
                                widget.request!.step! >=
                                    1
                                    ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 30.r,
                                )
                                    : Icon(
                                  Icons.circle,
                                  color: Colors.black,
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
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                                width: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.7,
                                child: Text(
                                  '${widget.request!.description}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                                child:
                                widget.request!.step! >=
                                    2
                                    ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 30.r,
                                )
                                    : Icon(
                                  Icons.circle,
                                  color: Colors.black,
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
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Step 2 of 5',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Admin Looking at the matter',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.7,
                                child: Text(
                                  '${widget.request!.description}',
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
                                child:
                                widget.request!.step! >=
                                    3
                                    ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 30.r,
                                )
                                    : Icon(
                                  Icons.circle,
                                  color: Colors.black,
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
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                                width: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.7,
                                child: Text(
                                  '${widget.request!.responseAdmin}',
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
                                child:
                                widget.request!.step! >=
                                    4
                                    ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 30.r,
                                )
                                    : Icon(
                                  Icons.circle,
                                  color: Colors.black,
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
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                                child:
                                widget.request!.step! >=
                                    5
                                    ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 30.r,
                                )
                                    : Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 30.r,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                  )),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.87,
              //   child: SingleChildScrollView(
              //       child: StreamBuilder<QuerySnapshot>(
              //           stream: FirebaseFirestore.instance
              //               .collection('Requests')
              //               .where('id',
              //                   isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              //               .snapshots(),
              //           builder: (context, snapshot) {
              //             if (snapshot.hasData) {
              //               return Column(
              //                 children: List.generate(
              //                     snapshot.data!.docs.length,
              //                     (index) => Padding(
              //                         padding: EdgeInsets.all(20.h),
              //                         child: Column(
              //                           children: [
              //                             Container(
              //                               width:
              //                                   MediaQuery.of(context).size.width,
              //                               decoration: BoxDecoration(
              //                                 color: Colors.white,
              //                                 borderRadius:
              //                                     BorderRadius.circular(10.r),
              //                               ),
              //                               padding: EdgeInsets.all(10.h),
              //                               child: Column(
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.start,
              //                                 children: [
              //                                   Container(
              //                                     width: MediaQuery.of(context).size.width,
              //                                     child: Row(
              //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                                       children: [
              //                                         Text(
              //                                           '${snapshot.data!.docs.elementAt(index)['title']}',
              //                                           style: GoogleFonts
              //                                               .nunitoSans(
              //                                                   color: Colors
              //                                                       .black,
              //                                                   fontSize:
              //                                                       15.sp,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .w500),
              //                                         ),
              //                                         Container(
              //                                           decoration:
              //                                               BoxDecoration(
              //                                             borderRadius:
              //                                                 BorderRadius
              //                                                     .circular(
              //                                                         10.r),
              //                                             color: Colors
              //                                                 .yellow.shade700,
              //                                           ),
              //                                           padding:
              //                                               EdgeInsets.all(5.w),
              //                                           child: Text(
              //                                             'In Progress',
              //                                             style: GoogleFonts
              //                                                 .nunitoSans(
              //                                                     color: Colors
              //                                                         .white,
              //                                                     fontSize:
              //                                                         12.sp,
              //                                                     fontWeight:
              //                                                         FontWeight
              //                                                             .w500),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   SizedBox(
              //                                     height: 10,
              //                                   ),
              //                                   Container(
              //                                     width:
              //                                         MediaQuery.of(context)
              //                                                 .size
              //                                                 .width *
              //                                             0.68,
              //                                     child: Text(
              //                                       '${snapshot.data!.docs.elementAt(index)['status']}',
              //                                       style: GoogleFonts
              //                                           .nunitoSans(
              //                                               color:
              //                                                   Colors.grey,
              //                                               fontSize: 12.sp,
              //                                               fontWeight:
              //                                                   FontWeight
              //                                                       .w500),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               height: 20.h,
              //                             ),
              //                             Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               children: [
              //                                 Column(
              //                                   children: [
              //                                     Container(
              //                                       decoration: BoxDecoration(
              //                                         color: Colors.white,
              //                                         shape: BoxShape.circle,
              //                                       ),
              //                                       child: snapshot.data!.docs
              //                                                       .elementAt(
              //                                                           index)[
              //                                                   'step'] >=
              //                                               1
              //                                           ? Icon(
              //                                               Icons.check_circle,
              //                                               color: Colors.green,
              //                                               size: 30.r,
              //                                             )
              //                                           : Icon(
              //                                               Icons.circle,
              //                                               color: Colors.black,
              //                                               size: 30.r,
              //                                             ),
              //                                     ),
              //                                     Container(
              //                                       height: 150,
              //                                       child: DottedLine(
              //                                         direction: Axis.vertical,
              //                                       ),
              //                                     )
              //                                   ],
              //                                 ),
              //                                 SizedBox(
              //                                   width: 10.w,
              //                                 ),
              //                                 Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                       'Step 1 of 5',
              //                                       style: GoogleFonts.nunitoSans(
              //                                           color: Colors.black,
              //                                           fontSize: 20.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500),
              //                                     ),
              //                                     Text(
              //                                       'Request Submitted',
              //                                       style: GoogleFonts.nunitoSans(
              //                                           color: Colors.black,
              //                                           fontSize: 15.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500),
              //                                     ),
              //                                     Container(
              //                                       width: MediaQuery.of(context)
              //                                               .size
              //                                               .width *
              //                                           0.7,
              //                                       child: Text(
              //                                         '${snapshot.data!.docs.elementAt(index)['details']}',
              //                                         style:
              //                                             GoogleFonts.nunitoSans(
              //                                                 color: Colors.black,
              //                                                 fontSize: 12.sp,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             ),
              //                             Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               children: [
              //                                 Column(
              //                                   children: [
              //                                     Container(
              //                                       decoration: BoxDecoration(
              //                                         color: Colors.white,
              //                                         shape: BoxShape.circle,
              //                                       ),
              //                                       child: snapshot.data!.docs
              //                                                       .elementAt(
              //                                                           index)[
              //                                                   'step'] >=
              //                                               2
              //                                           ? Icon(
              //                                               Icons.check_circle,
              //                                               color: Colors.green,
              //                                               size: 30.r,
              //                                             )
              //                                           : Icon(
              //                                               Icons.circle,
              //                                               color: Colors.black,
              //                                               size: 30.r,
              //                                             ),
              //                                     ),
              //                                     Container(
              //                                       height: 150,
              //                                       child: DottedLine(
              //                                         direction: Axis.vertical,
              //                                       ),
              //                                     )
              //                                   ],
              //                                 ),
              //                                 SizedBox(
              //                                   width: 10.w,
              //                                 ),
              //                                 Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                       'Step 2 of 5',
              //                                       style: GoogleFonts.nunitoSans(
              //                                           color: Colors.black,
              //                                           fontSize: 20.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500),
              //                                     ),
              //                                     Text(
              //                                       'Admin Looking at the mater',
              //                                       style: GoogleFonts.nunitoSans(
              //                                           color: Colors.black,
              //                                           fontSize: 15.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500),
              //                                     ),
              //                                     Container(
              //                                       width: MediaQuery.of(context)
              //                                               .size
              //                                               .width *
              //                                           0.7,
              //                                       child: Text(
              //                                         '${snapshot.data!.docs.elementAt(index)['details']}',
              //                                         style:
              //                                             GoogleFonts.nunitoSans(
              //                                                 color: Colors.black,
              //                                                 fontSize: 12.sp,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             ),
              //                             Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               children: [
              //                                 Column(
              //                                   children: [
              //                                     Container(
              //                                       decoration: BoxDecoration(
              //                                         color: Colors.white,
              //                                         shape: BoxShape.circle,
              //                                       ),
              //                                       child: snapshot.data!.docs
              //                                                       .elementAt(
              //                                                           index)[
              //                                                   'step'] >=
              //                                               3
              //                                           ? Icon(
              //                                               Icons.check_circle,
              //                                               color: Colors.green,
              //                                               size: 30.r,
              //                                             )
              //                                           : Icon(
              //                                               Icons.circle,
              //                                               color: Colors.black,
              //                                               size: 30.r,
              //                                             ),
              //                                     ),
              //                                     Container(
              //                                       height: 150,
              //                                       child: DottedLine(
              //                                         direction: Axis.vertical,
              //                                       ),
              //                                     )
              //                                   ],
              //                                 ),
              //                                 SizedBox(
              //                                   width: 10.w,
              //                                 ),
              //                                 Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                       'Step 3 of 5',
              //                                       style: GoogleFonts.nunitoSans(
              //                                           color: Colors.black,
              //                                           fontSize: 20.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500),
              //                                     ),
              //                                     Text(
              //                                       'Admin initiated the process',
              //                                       style: GoogleFonts.nunitoSans(
              //                                           color: Colors.black,
              //                                           fontSize: 15.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500),
              //                                     ),
              //                                     Container(
              //                                       width: MediaQuery.of(context)
              //                                               .size
              //                                               .width *
              //                                           0.7,
              //                                       child: Text(
              //                                         '${snapshot.data!.docs.elementAt(index)['responseByAdmin']}',
              //                                         style:
              //                                             GoogleFonts.nunitoSans(
              //                                                 color: Colors.black,
              //                                                 fontSize: 12.sp,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w500),
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             ),
              //                             Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               children: [
              //                                 Column(
              //                                   children: [
              //                                     Container(
              //                                       decoration: BoxDecoration(
              //                                         color: Colors.white,
              //                                         shape: BoxShape.circle,
              //                                       ),
              //                                       child: snapshot.data!.docs
              //                                                       .elementAt(
              //                                                           index)[
              //                                                   'step'] >=
              //                                               4
              //                                           ? Icon(
              //                                               Icons.check_circle,
              //                                               color: Colors.green,
              //                                               size: 30.r,
              //                                             )
              //                                           : Icon(
              //                                               Icons.circle,
              //                                               color: Colors.black,
              //                                               size: 30.r,
              //                                             ),
              //                                     ),
              //                                     Container(
              //                                       height: 150,
              //                                       child: DottedLine(
              //                                         direction: Axis.vertical,
              //                                       ),
              //                                     )
              //                                   ],
              //                                 ),
              //                                 SizedBox(
              //                                   width: 10.w,
              //                                 ),
              //                                 Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                       'Step 4 of 5',
              //                                       style: GoogleFonts.nunitoSans(
              //                                           color: Colors.black,
              //                                           fontSize: 20.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500),
              //                                     ),
              //                                     Text(
              //                                       'Under Process',
              //                                       style: GoogleFonts.nunitoSans(
              //                                           color: Colors.black,
              //                                           fontSize: 15.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500),
              //                                     ),
              //                                     // Container(
              //                                     //   width: MediaQuery.of(context).size.width*0.7,
              //                                     //   child: Text(
              //                                     //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra ridiculus odio odio turpis velit. Sodales blandit cursus est non. In placerat eget maecenas feugiat sem.',
              //                                     //     style: GoogleFonts.nunitoSans(
              //                                     //         color: Colors.black,
              //                                     //         fontSize: 12.sp,
              //                                     //         fontWeight: FontWeight.w500),
              //                                     //   ),
              //                                     // ),
              //                                   ],
              //                                 )
              //                               ],
              //                             ),
              //                             Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               children: [
              //                                 Column(
              //                                   children: [
              //                                     Container(
              //                                       decoration: BoxDecoration(
              //                                         color: Colors.white,
              //                                         shape: BoxShape.circle,
              //                                       ),
              //                                       child: snapshot.data!.docs
              //                                                       .elementAt(
              //                                                           index)[
              //                                                   'step'] >=
              //                                               5
              //                                           ? Icon(
              //                                               Icons.check_circle,
              //                                               color: Colors.green,
              //                                               size: 30.r,
              //                                             )
              //                                           : Icon(
              //                                               Icons.circle,
              //                                               color: Colors.black,
              //                                               size: 30.r,
              //                                             ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 SizedBox(
              //                                   width: 10.w,
              //                                 ),
              //                                 Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     Text(
              //                                       'Step 5 of 5',
              //                                       style: GoogleFonts.nunitoSans(
              //                                           color: Colors.black,
              //                                           fontSize: 20.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500),
              //                                     ),
              //                                     Text(
              //                                       'Request Resolved',
              //                                       style: GoogleFonts.nunitoSans(
              //                                           color: Colors.black,
              //                                           fontSize: 15.sp,
              //                                           fontWeight:
              //                                               FontWeight.w500),
              //                                     ),
              //                                     // Container(
              //                                     //   width: MediaQuery.of(context).size.width*0.7,
              //                                     //   child: Text(
              //                                     //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra ridiculus odio odio turpis velit. Sodales blandit cursus est non. In placerat eget maecenas feugiat sem.',
              //                                     //     style: GoogleFonts.nunitoSans(
              //                                     //         color: Colors.black,
              //                                     //         fontSize: 12.sp,
              //                                     //         fontWeight: FontWeight.w500),
              //                                     //   ),
              //                                     // ),
              //                                   ],
              //                                 )
              //                               ],
              //                             ),
              //                           ],
              //                         ))
              //                 ),
              //               );
              //             } else {
              //               return Container();
              //             }
              //           })),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
