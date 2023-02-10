import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Views/NotificationsPage.dart';
import '../providers/unit_provider.dart';
import '../providers/user_provider.dart';
import 'AddPayment.dart';
import 'AdminBookingDetailsPage.dart';
import 'AdminRequestFilterPage.dart';
import 'AdminRoomDetailsPage.dart';
import 'AdminTenantDetailsPage.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
              Container(
                height: MediaQuery.of(context).size.height * 0.73,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15.0.w, right: 15.w, top: 20.h, bottom: 10.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ' Upcoming Payments',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    var msg = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RequestFilterPage(
                                                title: 'Upcoming Payments Filter',
                                                page: 0)));
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
                            SizedBox(height: 10.h,),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPayment()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add Payment',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 15.w,),
                                  Icon(
                                    Icons.add_circle,
                                    color: Theme.of(context).primaryColor,
                                    size: 25.sp,
                                  ),
                                ],
                              ),
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
                                    int.parse(unit
                                        .bookingList[index].paymentDate!
                                        .split('-')[2]),
                                    int.parse(unit
                                        .bookingList[index].paymentDate!
                                        .split('-')[1]) + 1 ,
                                    int.parse(unit
                                        .bookingList[index].paymentDate!
                                        .split('-')[0]));
                                var d2 = DateTime.now();

                                if (requestSort.isNotEmpty ||
                                    (requestSort['order'] != '' &&
                                        requestSort['days'] == '')) {
                                  if (requestSort['order'] == 'Ascending') {
                                    unit.bookingList.sort((a, b) =>
                                        a.payment!.compareTo(b.payment!));
                                  } else {
                                    unit.bookingList.sort((a, b) =>
                                        b.payment!.compareTo(a.payment!));
                                  }
                                }

                                return d1.difference(d2).inDays <= 15 || d1.difference(d2).inDays >= 15
                                    ? requestSort.isEmpty ||
                                            (requestSort['days'] == '')
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
                                                                '${user.usersList.where((u) => u.uid == unit.bookingList[index].bookBy).first.nationality}',
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
                                        : requestSort.isNotEmpty &&
                                                (requestSort['days'] != '')
                                            ? d1.difference(d2).inDays <=
                                                    int.parse(
                                                        requestSort['days'])
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  AdminTenantDetailsPage(
                                                                    tenant: unit
                                                                            .bookingList[
                                                                        index],
                                                                  )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r)),
                                                      padding:
                                                          EdgeInsets.all(10.h),
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
                                                                      color: Colors
                                                                          .grey,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(user
                                                                              .usersList
                                                                              .where((u) => u.uid == unit.bookingList[index].bookBy)
                                                                              .first
                                                                              .profilePicture!),
                                                                          fit: BoxFit.fill)),
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
                                                                          fontSize: 15
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .location_on,
                                                                          color:
                                                                              Theme.of(context).primaryColor,
                                                                          size:
                                                                              15.sp,
                                                                        ),
                                                                        Text(
                                                                          '${unit.unitList.where((u) => u.uid == unit.bookingList[index].unitId).first.street} ${unit.unitList.where((u) => u.uid == unit.bookingList[index].unitId).first.postalCode}',
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: GoogleFonts.nunitoSans(
                                                                              color: Colors.grey,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w500),
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
                                                            style: GoogleFonts
                                                                .nunitoSans(
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
                                                    ),
                                                  )
                                                : Container()
                                            : Container()
                                    : Container();
                              })
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Payments()));
          },
          label: Text('Payments', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        elevation: 0.0,
      ),
    );
  }
}

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var unit = Provider.of<UnitProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SizedBox(
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
                      ],
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  itemCount: unit.paymentsList.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 8.h),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tenant Name: ${unit.paymentsList[index].selectedUser}', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),),
                          SizedBox(height: 5.h,),
                          Text('Payment Type: ${unit.paymentsList[index].paymentType}', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
                          SizedBox(height: 5.h,),
                          Text('Unit Name: ${unit.paymentsList[index].unitTitle}', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
                          SizedBox(height: 5.h,),
                          Text('Room Name: ${unit.paymentsList[index].roomTitle}', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
                          SizedBox(height: 5.h,),
                          Text('Amount: \$ ${unit.paymentsList[index].amount}', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
                          SizedBox(height: 5.h,),
                          Text('Due Date: ${unit.paymentsList[index].dueDate}', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
                          SizedBox(height: 5.h,),
                          Text('Remark: ${unit.paymentsList[index].remark}', overflow: TextOverflow.ellipsis, maxLines: 3, style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
                          SizedBox(height: 5.h,),
                          Text('Invoice:', overflow: TextOverflow.ellipsis, maxLines: 3, style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
                          SizedBox(height: 5.h,),
                          ClipRRect(borderRadius: BorderRadius.circular(10.r),child: SizedBox(height: 120.h, width: double.infinity,child: unit.paymentsList[index].invoice! != null && unit.paymentsList[index].invoice! != '' ?
                          Image.network(unit.paymentsList[index].invoice!, fit: BoxFit.cover,) : Icon(Icons.broken_image, size: 120,)))
                        ],
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}

