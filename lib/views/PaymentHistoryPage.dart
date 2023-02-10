import 'package:barleryroof/providers/unit_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'NotificationsPage.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var unit = Provider.of<UnitProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                    height: 120.h,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.455,
                    margin: EdgeInsets.only(top: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                ' My Payment History',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          user.user!.paymentHistory!.length > 0
                              ? ListView.builder(
                                  itemCount: user.user!.paymentHistory!.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      padding: EdgeInsets.all(10.h),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  ' \$ ${user.user!.paymentHistory![index]['amount']}',
                                                  style: GoogleFonts.nunitoSans(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  ' ${user.user!.paymentHistory![index]['date']}',
                                                  style: GoogleFonts.nunitoSans(
                                                      color: Colors.grey,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            ' ${user.user!.paymentHistory![index]['detail']}',
                                            style: GoogleFonts.nunitoSans(
                                                color: Colors.grey,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                              : Container(
                                  height: 200.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      'No Payment History',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
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
            Positioned(
              top: MediaQuery.of(context).size.height * 0.22,
              left: 20.w,
              right: 20.w,
              child: ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var latestItems = [];
                    var item = [];
                    user.user!.paymentHistory!.forEach((d) {
                      if(d['bookingId'] != ''){
                        var date1 = DateTime(
                            int.parse(d['date'].split('-')[2]),
                            int.parse(d['date'].split('-')[1]),
                            int.parse(d['date'].split('-')[0]));
                        var date2 = DateTime.now();

                        latestItems.add(date1.difference(date2).inDays);
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
                            latestItems.reduce(
                                    (curr, next) => curr < next ? curr : next)) {
                          item.add(d);
                        }
                      }
                    });

                    return Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.all(10.w),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.grey.shade200, width: 2)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  b.uid == item[0]['bookingId'])
                                              .first
                                              .unitId)
                                      .length >
                                  0
                              ? Text(
                                  ' Room ${unit.unitList.where((u) => u.uid == unit.bookingList.where((b) => b.uid == item[0]['bookingId']).first.unitId).first.rooms!.where((r) => r['uid'] == unit.bookingList.where((b) => b.uid == item[0]['bookingId']).first.roomId).first['title']}',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  'No payment done till so far',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                          // Text(
                          //   ' 2 Months Remaining on Tenancy',
                          //   style: GoogleFonts.nunitoSans(
                          //       color: Colors.grey,
                          //       fontSize: 14.sp,
                          //       fontWeight: FontWeight.w500),
                          // ),
                          Container(
                              margin: EdgeInsets.only(top: 10.h),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Last Payment',
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            item.length > 0
                                                ? '\$${item[0]['amount']}'
                                                : '\$ 0.0',
                                            style: GoogleFonts.nunitoSans(
                                                color: Colors.black,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            item.length > 0
                                                ? '${item[0]['date']}'
                                                : 'xx-xx-xxxx',
                                            style: GoogleFonts.nunitoSans(
                                                color: Colors.black,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Next Payment',
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            item.length > 0
                                                ? '\$${item[0]['amount']}'
                                                : '\$ 0.0',
                                            style: GoogleFonts.nunitoSans(
                                                color: Colors.black,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            item.length > 0
                                                ? '${DateTime(int.parse(item[0]["date"].split('-')[2]), int.parse(item[0]["date"].split('-')[1]) + 1, int.parse(item[0]["date"].split('-')[0])).difference(DateTime.now()).inDays} days'
                                                : 'xx-xx-xxxx',
                                            style: GoogleFonts.nunitoSans(
                                                color: Colors.black,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500),
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}
