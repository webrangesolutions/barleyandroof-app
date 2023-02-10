import 'package:barleryroof/Views/AllRoomsPage.dart';
import 'package:barleryroof/Views/RequestAService.dart';
import 'package:barleryroof/Views/RoomDetailsPage.dart';
import 'package:barleryroof/constant.dart';
import 'package:barleryroof/models/announce_model.dart';
import 'package:barleryroof/providers/announe_provider.dart';
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

import 'NotificationsPage.dart';
import 'RequestApplyPage.dart';
import "dart:math";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // check if any payment is pending

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var unit = Provider.of<UnitProvider>(context);
    var announce = Provider.of<AnnounceProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              print(announce.announceList.length);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (_) => NotificationsPage()));
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
                  height: 60.h,
                ),
              ],
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.22,
                left: 1.w,
                right: 1.w,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.71,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  ' Announcements',
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
                            unit.unitList.where((u) => u.tenants!.contains(user.user!.uid) == true).length > 0 ?
                            announce.announceList.length > 0 ?
                            ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index){
                                  List<AnnounceModel> sortedAL = announce.announceList.where((a) => a.type == 'Global').length > 0 ? announce.announceList.where((a) => a.type == 'Global').toList() : [];
                                  sortedAL.sort((a, b) => int.parse(b.timestamp!).compareTo(int.parse(a.timestamp!)));
                                  var x = sortedAL[index];

                                  return x.type == 'Global' ?
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.r),
                                        border: Border.all(
                                            color: CupertinoColors.systemYellow)),
                                    padding: EdgeInsets.all(10.h),
                                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Row(
                                      children: [
                                        ImageIcon(
                                          AssetImage('assets/images/siren.png'),
                                          color: CupertinoColors.systemYellow,
                                          size: 40.w,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width *
                                                  0.65,
                                              child: Text(
                                                ' ${x.title}',
                                                style: GoogleFonts.nunitoSans(
                                                    color: Colors.black,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500),
                                                maxLines: 1,
                                              ),
                                            ),
                                            Container(
                                              width:
                                              MediaQuery.of(context).size.width * 0.5,
                                              child: Text(
                                                ' ${x.description}',
                                                style: GoogleFonts.nunitoSans(
                                                    color: Colors.grey,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ) : Container();
                                }
                            ) : Container()
                                : Container(),
                            SizedBox(
                              height: 5.h,
                            ),
                            unit.unitList.where((u) => u.tenants!.contains(user.user!.uid) == true).length > 0 ?
                            announce.announceList.length > 0 ?
                            ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index){
                                  List<AnnounceModel> sortedAL = announce.announceList.where((a) => a.type == 'Project').toList().length > 0 ? announce.announceList.where((a) => a.type == 'Project').toList() : [];
                                  sortedAL.sort((a, b) => int.parse(b.timestamp!).compareTo(int.parse(a.timestamp!)));
                                  var x = sortedAL[index];

                                  return x.type == 'Project' ?
                                  unit.unitList.where((u) => (u.title == x.project) && u.tenants!.contains(user.user!.uid)).length > 0 ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.r),
                                        border: Border.all(
                                            color: CupertinoColors.systemYellow)),
                                    padding: EdgeInsets.all(10.h),
                                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Row(
                                      children: [
                                        ImageIcon(
                                          AssetImage('assets/images/siren.png'),
                                          color: CupertinoColors.systemYellow,
                                          size: 40.w,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width *
                                                  0.65,
                                              child: Text(
                                                ' ${x.title}',
                                                style: GoogleFonts.nunitoSans(
                                                    color: Colors.black,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500),
                                                maxLines: 1,
                                              ),
                                            ),
                                            Container(
                                              width:
                                              MediaQuery.of(context).size.width * 0.5,
                                              child: Text(
                                                ' ${x.description}',
                                                style: GoogleFonts.nunitoSans(
                                                    color: Colors.grey,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ) : Container() : Container();
                                }
                            ) : Container()
                            : Container(),
                          ],
                        ) ,
                        SizedBox(
                          height: 10.w,
                        ),
                        Column(
                          children: [
                            user.user!.name != 'Admin'
                                ? ListView.builder(
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var latestItems = [];
                                      var item = [];

                                      if(user.user!.paymentHistory!.length > 0){
                                        user.user!.paymentHistory!.forEach((d) {
                                          if(d['bookingId'] != ''){
                                            var date1 = DateTime(
                                                int.parse(d['date'].split('-')[2]),
                                                int.parse(d['date'].split('-')[1]),
                                                int.parse(d['date'].split('-')[0]));
                                            var date2 = DateTime.now();

                                            latestItems.add(
                                                date1.difference(date2).inDays);
                                          }
                                        });

                                        user.user!.paymentHistory!.forEach((d) {
                                          if(d['bookingId'] != ''){
                                            var date1 = DateTime(
                                                int.parse(d['date'].split('-')[2]),
                                                int.parse(d['date'].split('-')[1]),
                                                int.parse(d['date'].split('-')[0]));
                                            var date2 = DateTime.now();

                                            if (date1.difference(date2).inDays ==
                                                latestItems.reduce((curr, next) =>
                                                curr < next ? curr : next)) {
                                              item.add(d);
                                            }
                                          }
                                        });
                                      }

                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        padding: EdgeInsets.all(10.w),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.grey.shade200,
                                                width: 2)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            item.length > 0 && unit.bookingList
                                                .where((b) =>
                                            b.uid ==
                                                item[0][
                                                'bookingId']).length > 0 && unit.unitList
                                                        .where((u) =>
                                                            u.uid ==
                                                            unit.bookingList
                                                                .where((b) =>
                                                                    b.uid ==
                                                                    item[0][
                                                                        'bookingId'])
                                                                .first
                                                                .unitId)
                                                        .length >
                                                    0
                                                ? Text(
                                                    ' Room ${unit.unitList.where((u) => u.uid == unit.bookingList.where((b) => b.uid == item[0]['bookingId']).first.unitId).first.rooms!.where((r) => r['uid'] == unit.bookingList.where((b) => b.uid == item[0]['bookingId']).first.roomId).first['title']}',
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                            color: Colors.black,
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  )
                                                : Text('No Payment done till so far',  overflow: TextOverflow.ellipsis,
                                              maxLines: 1,style:
                                            GoogleFonts.nunitoSans(
                                                color: Colors.black,
                                                fontSize: 20.sp,
                                                fontWeight:
                                                FontWeight
                                                    .w500),),
                                            // Text(
                                            //   ' 2 Months Remaining on Tenancy',
                                            //   style: GoogleFonts.nunitoSans(
                                            //       color: Colors.grey,
                                            //       fontSize: 14.sp,
                                            //       fontWeight: FontWeight.w500),
                                            // ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.h),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding: EdgeInsets.all(10.h),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Last Payment',
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              item.length > 0
                                                                  ? '\$${item[0]['amount']}'
                                                                  : '\$ 0.0',
                                                              style: GoogleFonts.nunitoSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              item.length > 0
                                                                  ? '${item[0]['date']}'
                                                                  : 'xx-xx-xxxx',
                                                              style: GoogleFonts.nunitoSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Next Payment',
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              item.length > 0
                                                                  ? '\$${item[0]['amount']}'
                                                                  : '\$ 0.0',
                                                              style: GoogleFonts.nunitoSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              item.length > 0
                                                                  ? '${DateTime(int.parse(item[0]["date"].split('-')[2]), int.parse(item[0]["date"].split('-')[1]) + 1, int.parse(item[0]["date"].split('-')[0])).difference(DateTime.now()).inDays} days'
                                                                  : 'xx-xx-xxxx',
                                                              style: GoogleFonts.nunitoSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            // Text(
                                                            //   '${DateTime(int.parse(item[0]['date'].split('-')[2]), int.parse(item[0]['date'].split('-')[1]) + 1, int.parse(item[0]['date'].split('-')[0])).day.toString() + '-' + DateTime(int.parse(item[0]['date'].split('-')[2]), int.parse(item[0]['date'].split('-')[1]) + 1, int.parse(item[0]['date'].split('-')[0])).month.toString() + '-' + DateTime(int.parse(item[0]['date'].split('-')[2]), int.parse(item[0]['date'].split('-')[1]) + 1, int.parse(item[0]['date'].split('-')[0])).year.toString()}(${
                                                            //       DateTime(int.parse(item[0]['date'].split('-')[2]), int.parse(item[0]['date'].split('-')[1]) + 1, int.parse(item[0]['date'].split('-')[0])).difference(DateTime.now()).inDays
                                                            //   } days)',
                                                            //   style: GoogleFonts
                                                            //       .nunitoSans(
                                                            //           color: Colors
                                                            //               .black,
                                                            //           fontSize:
                                                            //               13.sp,
                                                            //           fontWeight:
                                                            //               FontWeight
                                                            //                   .w500),
                                                            // ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                      );
                                    })
                                : Container(),
                            SizedBox(
                              height: 20.h,
                            ),
                            unit.unitList.where((u) => u.tenants!.contains(user.user!.uid) == true).length > 0 ? Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Text(
                                      ' My Requests',
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
                                  height: 130,
                                  margin:
                                  EdgeInsets.symmetric(horizontal: 20),
                                  child:
                                  user.requestsList
                                      .where((r) => (r.createdById == user.user!.uid) && (r.closed == false))
                                      .length >
                                      0
                                      ? ListView.builder(
                                      itemCount:
                                      user.requestsList
                                          .where((r) => (r.createdById == user.user!.uid) && (r.closed == false))
                                          .length,
                                      shrinkWrap: true,
                                      scrollDirection:
                                      Axis.horizontal,
                                      physics:
                                      BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var x = user.requestsList
                                            .where((r) => (r.createdById == user.user!.uid) && (r.closed == false))
                                            .toList()[index];

                                        return user.requestsList
                                            .where((r) => (r.createdById == user.user!.uid) && (r.closed == false)).length > 0
                                            ? GestureDetector(
                                          onTap: () {
                                            Navigator.of(
                                                context)
                                                .push(MaterialPageRoute(
                                                builder: (_) =>
                                                    RequestAService(request: x,)));
                                          },
                                          child: Container(
                                            width:
                                            MediaQuery.of(
                                                context)
                                                .size
                                                .width - 40,
                                            decoration:
                                            BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10.r),
                                              color:
                                              Colors.white,
                                            ),
                                            padding: EdgeInsets
                                                .symmetric(
                                                horizontal:
                                                10.h,
                                                vertical:
                                                5.h),
                                            margin:
                                            EdgeInsets.only(
                                                right: 10.h,
                                                bottom:
                                                10.h),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width:
                                                        MediaQuery.of(context).size.width * 0.6,
                                                        child:
                                                        Text(
                                                          '${x.title}',
                                                          style: GoogleFonts.nunitoSans(
                                                              color: Colors.black,
                                                              fontSize: 15.sp,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      x.step == 5 &&
                                                          x.closed == true
                                                          ? Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.r),
                                                          color: Colors.green.shade50,
                                                        ),
                                                        padding: EdgeInsets.all(5.w),
                                                        child: Text(
                                                          'Completed',
                                                          style: GoogleFonts.nunitoSans(color: Colors.green.shade900, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                        ),
                                                      )
                                                          : x.step != 5 && x.closed == false
                                                          ? Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.r),
                                                          color: Colors.yellow.shade50,
                                                        ),
                                                        padding: EdgeInsets.all(5.w),
                                                        child: Text(
                                                          'In Progress',
                                                          style: GoogleFonts.nunitoSans(color: Colors.yellow.shade700, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                        ),
                                                      )
                                                          : x.step != 5 && x.closed == true
                                                          ? Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.r),
                                                          color: Colors.red.shade50,
                                                        ),
                                                        padding: EdgeInsets.all(5.w),
                                                        child: Text(
                                                          'Not Completed',
                                                          style: GoogleFonts.nunitoSans(color: Colors.red.shade900, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                        ),
                                                      )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                  8.h,
                                                ),
                                                Text(
                                                  '${x.step} of 5 (${x.step == 1 ? 'Request Submitted' : x.step == 2 ? 'Admin Looking at the matter' : x.step == 3 ? 'Admin initiated the process' : x.step == 4 ? 'Under Process' : 'Request Resolved'})',
                                                  maxLines:
                                                  1,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  style: GoogleFonts.nunitoSans(
                                                      color: Colors
                                                          .grey,
                                                      fontSize: 12
                                                          .sp,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height:
                                                  8.h,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.8,
                                                  child:
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      x.step! >= 1
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
                                                      x.step! >= 2
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
                                                      x.step! >= 3
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
                                                      x.step! >= 4
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
                                                      x.step! >= 5
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
                                      })
                                      : Container(),
                                )
                                    : Text('No Requests')
                                ,
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (_) => RequestApplyPage()));

                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(18.h),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 50.h,
                                    child: Center(
                                      child: Text(
                                        'Request a Service',
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ) : Container(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ' Explore Other Rooms',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllRoomsPage()));
                                    },
                                    child: Text(
                                      ' See All',
                                      style: GoogleFonts.nunitoSans(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200.h,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(10.w),
                              child: ListView.builder(
                                  itemCount: unit.unitList.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RoomDetailsPage(
                                                      units:
                                                          unit.unitList[index],
                                                    )));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            height: 100.h,
                                            width: 150.h,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        '${unit.unitList[index].images![0]}'),
                                                    fit: BoxFit.fill)),
                                          ),
                                          Container(
                                            width: 150.h,
                                            margin: EdgeInsets.only(top: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${unit.unitList[index].title}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            size: 15.sp,
                                                          ),
                                                          Container(
                                                            width: 60.w,
                                                            child: Text(
                                                              '${unit.unitList[index].street} ${unit.unitList[index].postalCode}',
                                                              maxLines: 1,
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
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '${unit.unitList[index].rooms!.length} Rooms',
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
