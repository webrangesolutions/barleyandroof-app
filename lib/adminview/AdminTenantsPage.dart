import 'package:barleryroof/AdminView/AdminPaymentsDetailPage.dart';
import 'package:barleryroof/Views/RequestAService.dart';
import 'package:barleryroof/providers/unit_provider.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Views/NotificationsPage.dart';
import 'AdminBookingDetailsPage.dart';
import 'AdminRequestFilterPage.dart';
import 'AdminRoomDetailsPage.dart';
import 'AdminTenantDetailsPage.dart';

class AdminTenantsPage extends StatefulWidget {
  const AdminTenantsPage({Key? key}) : super(key: key);

  @override
  State<AdminTenantsPage> createState() => _AdminTenantsPageState();
}

class _AdminTenantsPageState extends State<AdminTenantsPage> {
  var requestSort = {};

  @override
  void initState() {
    requestSort.clear();
    super.initState();
  }

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
                height: MediaQuery.of(context).size.height * 0.18,
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
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        ' Tenants Moving In Next 3 Days',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunitoSans(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var msg = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestFilterPage(
                                    title: 'Tenants Moving Filter', page: 2)));
                        print(msg);
                        setState(() {
                          requestSort = msg;
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.white,
                          ),
                          child: Center(
                              child: Icon(
                            Icons.filter_alt,
                            size: 20.sp,
                          ))),
                    )
                  ],
                ),
              ),
              unit.bookingList.length > 0
                  ? ListView.builder(
                      itemCount: unit.bookingList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var d1 = DateTime(
                            int.parse(unit.bookingList[index].paymentDate!
                                .split('-')[2]),
                            int.parse(unit.bookingList[index].paymentDate!
                                .split('-')[1]) + 1,
                            int.parse(unit.bookingList[index].paymentDate!
                                .split('-')[0]));
                        var d2 = DateTime.now();

                        if (requestSort.isNotEmpty ||
                            (requestSort['order'] != '' &&
                                requestSort['days'] == '')) {
                          if (requestSort['order'] == 'Ascending') {
                            unit.bookingList.sort(
                                (a, b) => a.payment!.compareTo(b.payment!));
                          } else {
                            unit.bookingList.sort(
                                (a, b) => b.payment!.compareTo(a.payment!));
                          }
                        }

                        return d1.difference(d2).inDays <= 3 || d1.difference(d2).inDays >= 3
                            ? requestSort.isEmpty || (requestSort['days'] == '')
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  AdminTenantDetailsPage(
                                                    tenant:
                                                        unit.bookingList[index],
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      padding: EdgeInsets.all(10.h),
                                      margin: EdgeInsets.only(
                                          left: 20.w,
                                          right: 20.w,
                                          bottom: 10.h),
                                      child: Row(
                                        // mainAxisAlignment:
                                        // MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 30.h,
                                                  width: 30.h,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: NetworkImage(user
                                                              .usersList
                                                              .where((u) =>
                                                                  u.uid ==
                                                                  unit
                                                                      .bookingList[
                                                                          index]
                                                                      .bookBy)
                                                              .first
                                                              .profilePicture!),
                                                          fit: BoxFit.fill)),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      ' ${user.usersList.where((u) => u.uid == unit.bookingList[index].bookBy).first.name}',
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          size: 15.sp,
                                                        ),
                                                        unit.unitList
                                                                    .where((u) =>
                                                                        u.uid ==
                                                                        unit.bookingList[index]
                                                                            .unitId)
                                                                    .length >
                                                                0
                                                            ? Text(
                                                                '${unit.unitList.where((u) => u.uid == unit.bookingList[index].unitId).first.street} ${unit.unitList.where((u) => u.uid == unit.bookingList[index].unitId).first.postalCode}',
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: GoogleFonts.nunitoSans(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )
                                                            : Text(''),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "In ${d1.difference(d2).inDays} days",
                                            style: GoogleFonts.nunitoSans(
                                                color: Colors.grey,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : requestSort.isNotEmpty &&
                                        (requestSort['days'] != '')
                                    ? d1.difference(d2).inDays <=
                                            int.parse(requestSort['days'])
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          AdminTenantDetailsPage(
                                                            tenant:
                                                                unit.bookingList[
                                                                    index],
                                                          )));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r)),
                                              padding: EdgeInsets.all(10.h),
                                              margin: EdgeInsets.only(
                                                  left: 20.w,
                                                  right: 20.w,
                                                  bottom: 10.h),
                                              child: Row(
                                                // mainAxisAlignment:
                                                // MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 30.h,
                                                          width: 30.h,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.grey,
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image: NetworkImage(user
                                                                      .usersList
                                                                      .where((u) =>
                                                                          u.uid ==
                                                                          unit
                                                                              .bookingList[
                                                                                  index]
                                                                              .bookBy)
                                                                      .first
                                                                      .profilePicture!),
                                                                  fit: BoxFit
                                                                      .fill)),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              ' ${user.usersList.where((u) => u.uid == unit.bookingList[index].bookBy).first.name}',
                                                              style: GoogleFonts.nunitoSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 15.sp,
                                                                ),
                                                                Text(
                                                                  '${unit.unitList.where((u) => u.uid == unit.bookingList[index].unitId).first.street} ${unit.unitList.where((u) => u.uid == unit.bookingList[index].unitId).first.postalCode}',
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts.nunitoSans(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "In ${d1.difference(d2).inDays} days",
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                            color: Colors.grey,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container()
                                    : Container()
                            : Container();
                      })
                  : Container(),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.73,
              //   child: requestSort.isEmpty || requestSort['order'] == ''
              //       ? StreamBuilder<QuerySnapshot>(
              //           stream: FirebaseFirestore.instance
              //               .collection("Bookings")
              //               .snapshots(),
              //           builder: (context, snapshot) {
              //             return snapshot.hasData && snapshot.data != null
              //                 ? SingleChildScrollView(
              //                     child: Column(
              //                       children: [
              //                         Padding(
              //                           padding: EdgeInsets.symmetric(
              //                               horizontal: 20.0.w, vertical: 20.h),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.center,
              //                             children: [
              //                               Expanded(
              //                                 child: Text(
              //                                   ' Tenants Moving In Next 3 Days',
              //                                   maxLines: 1,
              //                                   overflow: TextOverflow.ellipsis,
              //                                   style: GoogleFonts.nunitoSans(
              //                                       color: Colors.black,
              //                                       fontSize: 16.sp,
              //                                       fontWeight: FontWeight.w500),
              //                                 ),
              //                               ),
              //                               SizedBox(
              //                                 width: 15.w,
              //                               ),
              //                               GestureDetector(
              //                                 onTap: () async {
              //                                   var msg = await Navigator.push(
              //                                       context,
              //                                       MaterialPageRoute(
              //                                           builder: (context) =>
              //                                               RequestFilterPage(
              //                                                   title:
              //                                                       'Tenants Moving Filter',
              //                                                   page: 2)));
              //                                   print(msg);
              //                                   setState(() {
              //                                     requestSort = msg;
              //                                   });
              //                                 },
              //                                 child: Container(
              //                                     padding: EdgeInsets.symmetric(
              //                                         horizontal: 8.w,
              //                                         vertical: 5.h),
              //                                     decoration: BoxDecoration(
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               8.r),
              //                                       color: Colors.white,
              //                                     ),
              //                                     child: Center(
              //                                         child: Icon(
              //                                       Icons.filter_alt,
              //                                       size: 20.sp,
              //                                     ))),
              //                               )
              //                             ],
              //                           ),
              //                         ),
              //                         Column(
              //                           children: List.generate(
              //                               snapshot.data!.docs.length,
              //                               (index) => FutureBuilder(
              //                                   future: FirebaseFirestore.instance
              //                                       .collection("Users")
              //                                       .doc(snapshot
              //                                           .data!.docs[index]["id"])
              //                                       .get(),
              //                                   builder: (context, userSnapshot) {
              //                                     return snapshot.hasData &&
              //                                             userSnapshot.data !=
              //                                                 null
              //                                         ? DateFormat("dd-MM-yyyy")
              //                                                         .parse((snapshot
              //                                                                 .data!
              //                                                                 .docs[index]
              //                                                             [
              //                                                             "period"]))
              //                                                         .difference(
              //                                                             DateTime
              //                                                                 .now())
              //                                                         .inDays >
              //                                                     0 &&
              //                                                 DateFormat("dd-MM-yyyy")
              //                                                         .parse((snapshot
              //                                                                 .data!
              //                                                                 .docs[index]
              //                                                             [
              //                                                             "period"]))
              //                                                         .difference(
              //                                                             DateTime
              //                                                                 .now())
              //                                                         .inDays <=
              //                                                     3
              //                                             ? GestureDetector(
              //                                                 onTap: () {
              //                                                   Navigator.of(context).push(
              //                                                       MaterialPageRoute(
              //                                                           builder: (_) =>
              //                                                               AdminTenantDetailsPage(
              //                                                                 id: snapshot.data!.docs[index].id,
              //                                                               )));
              //                                                 },
              //                                                 child: Container(
              //                                                   decoration: BoxDecoration(
              //                                                       color: Colors
              //                                                           .white,
              //                                                       borderRadius:
              //                                                           BorderRadius
              //                                                               .circular(
              //                                                                   10.r)),
              //                                                   padding:
              //                                                       EdgeInsets
              //                                                           .all(
              //                                                               10.h),
              //                                                   margin: EdgeInsets
              //                                                       .only(
              //                                                           left:
              //                                                               20.w,
              //                                                           right:
              //                                                               20.w,
              //                                                           bottom:
              //                                                               10.h),
              //                                                   child: Row(
              //                                                     mainAxisAlignment:
              //                                                         MainAxisAlignment
              //                                                             .spaceBetween,
              //                                                     children: [
              //                                                       Row(
              //                                                         children: [
              //                                                           Container(
              //                                                             height:
              //                                                                 30.h,
              //                                                             width:
              //                                                                 30.h,
              //                                                             decoration: BoxDecoration(
              //                                                                 color:
              //                                                                     Colors.grey,
              //                                                                 shape: BoxShape.circle,
              //                                                                 image: DecorationImage(image: NetworkImage(userSnapshot.data!['image']), fit: BoxFit.fill)),
              //                                                           ),
              //                                                           Column(
              //                                                             crossAxisAlignment:
              //                                                                 CrossAxisAlignment.start,
              //                                                             children: [
              //                                                               Text(
              //                                                                 ' ${userSnapshot.data!['name']}',
              //                                                                 style: GoogleFonts.nunitoSans(
              //                                                                     color: Colors.black,
              //                                                                     fontSize: 15.sp,
              //                                                                     fontWeight: FontWeight.w500),
              //                                                               ),
              //                                                               Row(
              //                                                                 children: [
              //                                                                   Icon(
              //                                                                     Icons.location_on,
              //                                                                     color: Theme.of(context).primaryColor,
              //                                                                     size: 20.w,
              //                                                                   ),
              //                                                                   FutureBuilder(
              //                                                                       future: FirebaseFirestore.instance.collection("Units").doc(snapshot.data!.docs[index]["roomId"]).get(),
              //                                                                       builder: (context, snapshot) {
              //                                                                         return snapshot.hasData && snapshot.data != null
              //                                                                             ? Text(
              //                                                                                 '${snapshot.data!['title']}',
              //                                                                                 style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
              //                                                                               )
              //                                                                             : Text("");
              //                                                                       }),
              //                                                                 ],
              //                                                               ),
              //                                                             ],
              //                                                           )
              //                                                         ],
              //                                                       ),
              //                                                       Text(
              //                                                         "In ${DateFormat("dd-MM-yyyy").parse((snapshot.data!.docs[index]["period"])).difference(DateTime.now()).inDays} days",
              //                                                         style: GoogleFonts.nunitoSans(
              //                                                             color: Colors
              //                                                                 .grey,
              //                                                             fontSize: 12
              //                                                                 .sp,
              //                                                             fontWeight:
              //                                                                 FontWeight.w500),
              //                                                       ),
              //                                                     ],
              //                                                   ),
              //                                                 ),
              //                                               )
              //                                             : Container()
              //                                         : Container();
              //                                   })),
              //                         )
              //                       ],
              //                     ),
              //                   )
              //                 : Container();
              //           })
              //       : StreamBuilder<QuerySnapshot>(
              //           stream: FirebaseFirestore.instance
              //               .collection("Bookings")
              //               .orderBy('price',
              //                   descending: requestSort['order'] == 'Descending'
              //                       ? true
              //                       : false)
              //               .snapshots(),
              //           builder: (context, snapshot) {
              //             return snapshot.hasData && snapshot.data != null
              //                 ? SingleChildScrollView(
              //                     child: Column(
              //                       children: [
              //                         Padding(
              //                           padding: EdgeInsets.symmetric(
              //                               horizontal: 20.0.w, vertical: 20.h),
              //                           child: Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.center,
              //                             children: [
              //                               Text(
              //                                 ' Tenants Moving In Next 3 Days',
              //                                 style: GoogleFonts.nunitoSans(
              //                                     color: Colors.black,
              //                                     fontSize: 17.sp,
              //                                     fontWeight: FontWeight.w500),
              //                               ),
              //                               SizedBox(
              //                                 width: 20.w,
              //                               ),
              //                               GestureDetector(
              //                                 onTap: () async {
              //                                   var msg = await Navigator.push(
              //                                       context,
              //                                       MaterialPageRoute(
              //                                           builder: (context) =>
              //                                               RequestFilterPage(
              //                                                   title:
              //                                                       'Tenants Moving Filter',
              //                                                   page: 2)));
              //                                   print(msg);
              //                                   setState(() {
              //                                     requestSort = msg;
              //                                   });
              //                                 },
              //                                 child: Container(
              //                                     padding: EdgeInsets.symmetric(
              //                                         horizontal: 8.w,
              //                                         vertical: 5.h),
              //                                     decoration: BoxDecoration(
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               8.r),
              //                                       color: Colors.white,
              //                                     ),
              //                                     child: Center(
              //                                         child: Icon(
              //                                       Icons.filter_alt,
              //                                       size: 20.sp,
              //                                     ))),
              //                               )
              //                             ],
              //                           ),
              //                         ),
              //                         Column(
              //                           children: List.generate(
              //                               snapshot.data!.docs.length,
              //                               (index) => FutureBuilder(
              //                                   future: FirebaseFirestore.instance
              //                                       .collection("Users")
              //                                       .doc(snapshot
              //                                           .data!.docs[index]["id"])
              //                                       .get(),
              //                                   builder: (context, userSnapshot) {
              //                                     return snapshot.hasData &&
              //                                             userSnapshot.data !=
              //                                                 null
              //                                         ? DateFormat("dd-MM-yyyy").parse((snapshot.data!.docs[index]["period"])).difference(DateTime.now()).inDays >
              //                                                     0 &&
              //                                                 DateFormat("dd-MM-yyyy").parse((snapshot.data!.docs[index]["period"])).difference(DateTime.now()).inDays <=
              //                                                     3
              //                                             ? requestSort.isEmpty ||
              //                                                     ((requestSort[
              //                                                                 'order'] ==
              //                                                             '') &&
              //                                                         (requestSort['days'] ==
              //                                                             ''))
              //                                                 ? GestureDetector(
              //                                                     onTap: () {
              //                                                       Navigator.of(
              //                                                               context)
              //                                                           .push(MaterialPageRoute(
              //                                                               builder: (_) => AdminTenantDetailsPage(
              //                                                                     id: snapshot.data!.docs[index].id,
              //                                                                   )));
              //                                                     },
              //                                                     child:
              //                                                         Container(
              //                                                       decoration: BoxDecoration(
              //                                                           color: Colors
              //                                                               .white,
              //                                                           borderRadius:
              //                                                               BorderRadius.circular(
              //                                                                   10.r)),
              //                                                       padding:
              //                                                           EdgeInsets
              //                                                               .all(10
              //                                                                   .h),
              //                                                       margin: EdgeInsets.only(
              //                                                           left:
              //                                                               20.w,
              //                                                           right:
              //                                                               20.w,
              //                                                           bottom:
              //                                                               10.h),
              //                                                       child: Row(
              //                                                         mainAxisAlignment:
              //                                                             MainAxisAlignment
              //                                                                 .spaceBetween,
              //                                                         children: [
              //                                                           Row(
              //                                                             children: [
              //                                                               Container(
              //                                                                 height:
              //                                                                     30.h,
              //                                                                 width:
              //                                                                     30.h,
              //                                                                 decoration: BoxDecoration(
              //                                                                     color: Colors.grey,
              //                                                                     shape: BoxShape.circle,
              //                                                                     image: DecorationImage(image: NetworkImage(userSnapshot.data!['image']), fit: BoxFit.fill)),
              //                                                               ),
              //                                                               Column(
              //                                                                 crossAxisAlignment:
              //                                                                     CrossAxisAlignment.start,
              //                                                                 children: [
              //                                                                   Text(
              //                                                                     ' ${userSnapshot.data!['name']}',
              //                                                                     style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
              //                                                                   ),
              //                                                                   Row(
              //                                                                     children: [
              //                                                                       Icon(
              //                                                                         Icons.location_on,
              //                                                                         color: Theme.of(context).primaryColor,
              //                                                                         size: 20.w,
              //                                                                       ),
              //                                                                       FutureBuilder(
              //                                                                           future: FirebaseFirestore.instance.collection("Units").doc(snapshot.data!.docs[index]["roomId"]).get(),
              //                                                                           builder: (context, snapshot) {
              //                                                                             return snapshot.hasData && snapshot.data != null
              //                                                                                 ? Text(
              //                                                                                     '${snapshot.data!['title']}',
              //                                                                                     style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
              //                                                                                   )
              //                                                                                 : Text("");
              //                                                                           }),
              //                                                                     ],
              //                                                                   ),
              //                                                                 ],
              //                                                               )
              //                                                             ],
              //                                                           ),
              //                                                           Text(
              //                                                             "In ${DateFormat("dd-MM-yyyy").parse((snapshot.data!.docs[index]["period"])).difference(DateTime.now()).inDays} days",
              //                                                             style: GoogleFonts.nunitoSans(
              //                                                                 color:
              //                                                                     Colors.grey,
              //                                                                 fontSize: 12.sp,
              //                                                                 fontWeight: FontWeight.w500),
              //                                                           ),
              //                                                         ],
              //                                                       ),
              //                                                     ),
              //                                                   )
              //                                                 : ((requestSort['days'] !=
              //                                                                 null) &&
              //                                                             (requestSort['order'] !=
              //                                                                 null)) &&
              //                                                         ((requestSort['days'] !=
              //                                                                 '') &&
              //                                                             (requestSort['order'] ==
              //                                                                 '')) &&
              //                                                         (DateFormat("dd-MM-yyyy")
              //                                                                 .parse((snapshot.data!.docs[index]["period"]))
              //                                                                 .difference(DateTime.now())
              //                                                                 .inDays <=
              //                                                             int.parse(requestSort['days']))
              //                                                     ? GestureDetector(
              //                                                         onTap: () {
              //                                                           Navigator.of(context).push(MaterialPageRoute(
              //                                                               builder: (_) => AdminTenantDetailsPage(
              //                                                                     id: snapshot.data!.docs[index].id,
              //                                                                   )));
              //                                                         },
              //                                                         child:
              //                                                             Container(
              //                                                           decoration: BoxDecoration(
              //                                                               color: Colors
              //                                                                   .white,
              //                                                               borderRadius:
              //                                                                   BorderRadius.circular(10.r)),
              //                                                           padding: EdgeInsets
              //                                                               .all(10
              //                                                                   .h),
              //                                                           margin: EdgeInsets.only(
              //                                                               left: 20
              //                                                                   .w,
              //                                                               right: 20
              //                                                                   .w,
              //                                                               bottom:
              //                                                                   10.h),
              //                                                           child:
              //                                                               Row(
              //                                                             mainAxisAlignment:
              //                                                                 MainAxisAlignment.spaceBetween,
              //                                                             children: [
              //                                                               Row(
              //                                                                 children: [
              //                                                                   Container(
              //                                                                     height: 30.h,
              //                                                                     width: 30.h,
              //                                                                     decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(userSnapshot.data!['image']), fit: BoxFit.fill)),
              //                                                                   ),
              //                                                                   Column(
              //                                                                     crossAxisAlignment: CrossAxisAlignment.start,
              //                                                                     children: [
              //                                                                       Text(
              //                                                                         ' ${userSnapshot.data!['name']}',
              //                                                                         style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
              //                                                                       ),
              //                                                                       Row(
              //                                                                         children: [
              //                                                                           Icon(
              //                                                                             Icons.location_on,
              //                                                                             color: Theme.of(context).primaryColor,
              //                                                                             size: 20.w,
              //                                                                           ),
              //                                                                           FutureBuilder(
              //                                                                               future: FirebaseFirestore.instance.collection("Units").doc(snapshot.data!.docs[index]["roomId"]).get(),
              //                                                                               builder: (context, snapshot) {
              //                                                                                 return snapshot.hasData && snapshot.data != null
              //                                                                                     ? Text(
              //                                                                                         '${snapshot.data!['title']}',
              //                                                                                         style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
              //                                                                                       )
              //                                                                                     : Text("");
              //                                                                               }),
              //                                                                         ],
              //                                                                       ),
              //                                                                     ],
              //                                                                   )
              //                                                                 ],
              //                                                               ),
              //                                                               Text(
              //                                                                 "In ${DateFormat("dd-MM-yyyy").parse((snapshot.data!.docs[index]["period"])).difference(DateTime.now()).inDays} days",
              //                                                                 style: GoogleFonts.nunitoSans(
              //                                                                     color: Colors.grey,
              //                                                                     fontSize: 12.sp,
              //                                                                     fontWeight: FontWeight.w500),
              //                                                               ),
              //                                                             ],
              //                                                           ),
              //                                                         ),
              //                                                       )
              //                                                     : ((requestSort['days'] != null) && (requestSort['order'] != null)) && ((requestSort['days'] == '') && (requestSort['order'] != ''))
              //                                                         ? GestureDetector(
              //                                                             onTap:
              //                                                                 () {
              //                                                               Navigator.of(context).push(MaterialPageRoute(
              //                                                                   builder: (_) => AdminTenantDetailsPage(
              //                                                                         id: snapshot.data!.docs[index].id,
              //                                                                       )));
              //                                                             },
              //                                                             child:
              //                                                                 Container(
              //                                                               decoration: BoxDecoration(
              //                                                                   color: Colors.white,
              //                                                                   borderRadius: BorderRadius.circular(10.r)),
              //                                                               padding:
              //                                                                   EdgeInsets.all(10.h),
              //                                                               margin: EdgeInsets.only(
              //                                                                   left: 20.w,
              //                                                                   right: 20.w,
              //                                                                   bottom: 10.h),
              //                                                               child:
              //                                                                   Row(
              //                                                                 mainAxisAlignment:
              //                                                                     MainAxisAlignment.spaceBetween,
              //                                                                 children: [
              //                                                                   Row(
              //                                                                     children: [
              //                                                                       Container(
              //                                                                         height: 30.h,
              //                                                                         width: 30.h,
              //                                                                         decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(userSnapshot.data!['image']), fit: BoxFit.fill)),
              //                                                                       ),
              //                                                                       Column(
              //                                                                         crossAxisAlignment: CrossAxisAlignment.start,
              //                                                                         children: [
              //                                                                           Text(
              //                                                                             ' ${userSnapshot.data!['name']}',
              //                                                                             style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
              //                                                                           ),
              //                                                                           Row(
              //                                                                             children: [
              //                                                                               Icon(
              //                                                                                 Icons.location_on,
              //                                                                                 color: Theme.of(context).primaryColor,
              //                                                                                 size: 20.w,
              //                                                                               ),
              //                                                                               FutureBuilder(
              //                                                                                   future: FirebaseFirestore.instance.collection("Units").doc(snapshot.data!.docs[index]["roomId"]).get(),
              //                                                                                   builder: (context, snapshot) {
              //                                                                                     return snapshot.hasData && snapshot.data != null
              //                                                                                         ? Text(
              //                                                                                             '${snapshot.data!['title']}',
              //                                                                                             style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
              //                                                                                           )
              //                                                                                         : Text("");
              //                                                                                   }),
              //                                                                             ],
              //                                                                           ),
              //                                                                         ],
              //                                                                       )
              //                                                                     ],
              //                                                                   ),
              //                                                                   Text(
              //                                                                     "In ${DateFormat("dd-MM-yyyy").parse((snapshot.data!.docs[index]["period"])).difference(DateTime.now()).inDays} days",
              //                                                                     style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
              //                                                                   ),
              //                                                                 ],
              //                                                               ),
              //                                                             ),
              //                                                           )
              //                                                         : ((requestSort['days'] != null) && (requestSort['order'] != null)) && ((requestSort['days'] != '') && (requestSort['order'] != '')) && (DateFormat("dd-MM-yyyy").parse((snapshot.data!.docs[index]["period"])).difference(DateTime.now()).inDays <= int.parse(requestSort['days']))
              //                                                             ? GestureDetector(
              //                                                                 onTap:
              //                                                                     () {
              //                                                                   Navigator.of(context).push(MaterialPageRoute(
              //                                                                       builder: (_) => AdminTenantDetailsPage(
              //                                                                             id: snapshot.data!.docs[index].id,
              //                                                                           )));
              //                                                                 },
              //                                                                 child:
              //                                                                     Container(
              //                                                                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
              //                                                                   padding: EdgeInsets.all(10.h),
              //                                                                   margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
              //                                                                   child: Row(
              //                                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                                                                     children: [
              //                                                                       Row(
              //                                                                         children: [
              //                                                                           Container(
              //                                                                             height: 30.h,
              //                                                                             width: 30.h,
              //                                                                             decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(userSnapshot.data!['image']), fit: BoxFit.fill)),
              //                                                                           ),
              //                                                                           Column(
              //                                                                             crossAxisAlignment: CrossAxisAlignment.start,
              //                                                                             children: [
              //                                                                               Text(
              //                                                                                 ' ${userSnapshot.data!['name']}',
              //                                                                                 style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
              //                                                                               ),
              //                                                                               Row(
              //                                                                                 children: [
              //                                                                                   Icon(
              //                                                                                     Icons.location_on,
              //                                                                                     color: Theme.of(context).primaryColor,
              //                                                                                     size: 20.w,
              //                                                                                   ),
              //                                                                                   FutureBuilder(
              //                                                                                       future: FirebaseFirestore.instance.collection("Units").doc(snapshot.data!.docs[index]["roomId"]).get(),
              //                                                                                       builder: (context, snapshot) {
              //                                                                                         return snapshot.hasData && snapshot.data != null
              //                                                                                             ? Text(
              //                                                                                                 '${snapshot.data!['title']}',
              //                                                                                                 style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
              //                                                                                               )
              //                                                                                             : Text("");
              //                                                                                       }),
              //                                                                                 ],
              //                                                                               ),
              //                                                                             ],
              //                                                                           )
              //                                                                         ],
              //                                                                       ),
              //                                                                       Text(
              //                                                                         "In ${DateFormat("dd-MM-yyyy").parse((snapshot.data!.docs[index]["period"])).difference(DateTime.now()).inDays} days",
              //                                                                         style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
              //                                                                       ),
              //                                                                     ],
              //                                                                   ),
              //                                                                 ),
              //                                                               )
              //                                                             : Container()
              //                                             : Container()
              //                                         : Container();
              //                                   })),
              //                         )
              //                       ],
              //                     ),
              //                   )
              //                 : Container();
              //           }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
