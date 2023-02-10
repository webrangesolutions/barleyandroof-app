import 'package:barleryroof/providers/unit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Views/BookPayment.dart';

class PendingBookings extends StatefulWidget {
  const PendingBookings({Key? key}) : super(key: key);

  @override
  State<PendingBookings> createState() => _PendingBookingsState();
}

class _PendingBookingsState extends State<PendingBookings> {
  @override
  Widget build(BuildContext context) {
    var units = Provider.of<UnitProvider>(context);

    return Scaffold(
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
                                'Pending Bookings',
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
              ListView.builder(
                  itemCount: units.bookingList
                      .where((b) => b.status!.toLowerCase().contains('payment not done'))
                      .length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var x = units.bookingList
                        .where((b) => b.status!.toLowerCase().contains('payment not done'))
                        .toList()[index];

                    return GestureDetector(
                      onTap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookPaymentPage(data: {
                                  'period': x.period,
                                  'startDate': x.startDate,
                                  'endDate': x.endDate,
                                  'passport': x.passport,
                                  'workPass': x.workPass,
                                  'roomId': x.roomId,
                                  'unitId': x.unitId,
                                  'uid': x.uid,
                                  'status': x.status
                                },)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.all(10.h),
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' Unit: ${units.unitList.where((u) => u.uid == x.unitId).first.title}',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  ' Room: ${units.unitList.where((u) => u.uid == x.unitId).first.rooms!.length > 0 ? units.unitList.where((u) => u.uid == x.unitId).first.rooms!.where((r) => r['uid'] == x.roomId).first['title'] : ''}',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
