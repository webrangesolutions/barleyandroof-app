import 'package:barleryroof/AdminView/AdminPaymentsDetailPage.dart';
import 'package:barleryroof/Views/RequestAService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Views/NotificationsPage.dart';
import '../providers/user_provider.dart';
import 'AdminBookingDetailsPage.dart';
import 'AdminRequestFilterPage.dart';
import 'AdminRoomDetailsPage.dart';
import 'AdminTenantDetailsPage.dart';

class AdminRequestsPage extends StatefulWidget {
  const AdminRequestsPage({Key? key}) : super(key: key);

  @override
  State<AdminRequestsPage> createState() => _AdminRequestsPageState();
}

class _AdminRequestsPageState extends State<AdminRequestsPage> {
  var requestSort = {};

  @override
  void initState() {
    requestSort.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
            Container(
              height: MediaQuery.of(context).size.height * 0.73,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0.w, vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' Tenants Requests',
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
                                          title: 'Requests Filter', page: 1)));

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
                    user.requestsList.length > 0
                        ? ListView.builder(
                            itemCount: user.requestsList.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  if (user.requestsList[index].step == 1) {
                                    await user.updateRequest(user.requestsList[index].uid, {'step': '2'});
                                  };

                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (_) => AdminBookingdetailsPage(
                                        request: user.requestsList[index],
                                      )));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  padding: EdgeInsets.all(10.h),
                                  margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${user.requestsList[index].title}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                            ),
                                            user.requestsList[index].step == 5 && user.requestsList[index].closed == true
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
                                                : user.requestsList[index].step != 5 && user.requestsList[index].closed == false
                                                ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.r),
                                                color: Colors.yellow.shade50,
                                              ),
                                              padding: EdgeInsets.all(5.w),
                                              child: Text(
                                                'In Progress',
                                                style:
                                                GoogleFonts.nunitoSans(color: Colors.yellow.shade700, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                              ),
                                            )
                                                : user.requestsList[index].step != 5 && user.requestsList[index].closed == true
                                                ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.r),
                                                color: Colors.red.shade50,
                                              ),
                                              padding: EdgeInsets.all(5.w),
                                              child: Text(
                                                'Not Completed',
                                                style: GoogleFonts.nunitoSans(
                                                    color: Colors.red.shade900, fontSize: 12.sp, fontWeight: FontWeight.w500),
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
                                        '${user.requestsList[index].step} of 5 (${user.requestsList[index].step == 1 ?
                                        'Request Submitted' : user.requestsList[index].step == 2 ?
                                        'Admin Looking at the matter' : user.requestsList[index].step == 3 ? 'Admin initiated the process' :
                                        user.requestsList[index].step == 4 ? 'Under Process' : 'Request Resolved'})',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: user.requestsList[index].closed == true && user.requestsList[index].step! < 1
                                                ? Colors.red
                                                : user.requestsList[index].step! >= 1
                                                ? Colors.green
                                                : Colors.black,
                                            size: 15,
                                          ),
                                          Expanded(child: DottedLine()),
                                          Icon(
                                            Icons.circle,
                                            color: user.requestsList[index].closed == true && user.requestsList[index].step! < 2
                                                ? Colors.red
                                                : user.requestsList[index].step! >= 2
                                                ? Colors.green
                                                : Colors.black,
                                            size: 15,
                                          ),
                                          Expanded(child: DottedLine()),
                                          Icon(
                                            Icons.circle,
                                            color: user.requestsList[index].closed == true && user.requestsList[index].step! < 3
                                                ? Colors.red
                                                : user.requestsList[index].step! >= 3
                                                ? Colors.green
                                                : Colors.black,
                                            size: 15,
                                          ),
                                          Expanded(child: DottedLine()),
                                          Icon(
                                            Icons.circle,
                                            color: user.requestsList[index].closed == true && user.requestsList[index].step! < 4
                                                ? Colors.red
                                                : user.requestsList[index].step! >= 4
                                                ? Colors.green
                                                : Colors.black,
                                            size: 15,
                                          ),
                                          Expanded(child: DottedLine()),
                                          Icon(
                                            Icons.circle,
                                            color: user.requestsList[index].closed == true && user.requestsList[index].step! < 5
                                                ? Colors.red
                                                : user.requestsList[index].step! >= 5
                                                ? Colors.green
                                                : Colors.black,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.82,
                                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10.r)),
                                        padding: EdgeInsets.all(10.h),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 30.h,
                                              width: 30.h,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(image: NetworkImage('${user.usersList.where((u) => u.uid == user.requestsList[index].createdById).first.profilePicture}'), fit: BoxFit.fill)),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ' ${user.usersList.where((u) => u.uid == user.requestsList[index].createdById).first.name}',
                                                  style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Theme.of(context).primaryColor,
                                                      size: 20.w,
                                                    ),
                                                    Text(
                                                      ' ${user.usersList.where((u) => u.uid == user.requestsList[index].createdById).first.nationality}',
                                                      style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashedHorizontalLine() {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.red,
                    thickness: 2,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class DotWidget extends StatelessWidget {
  final double totalWidth, dashWidth, emptyWidth, dashHeight;

  final Color dashColor;

  const DotWidget({
    this.totalWidth = 300,
    this.dashWidth = 10,
    this.emptyWidth = 5,
    this.dashHeight = 2,
    this.dashColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalWidth ~/ (dashWidth + emptyWidth),
        (_) => Container(
          width: dashWidth,
          height: dashHeight,
          color: dashColor,
          margin: EdgeInsets.only(left: emptyWidth / 2, right: emptyWidth / 2),
        ),
      ),
    );
  }
}
