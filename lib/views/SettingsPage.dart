import 'package:barleryroof/constant.dart';
import 'package:barleryroof/providers/unit_provider.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:barleryroof/views/PendingBookings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barleryroof/Views/LoginPage.dart';
import 'NotificationsPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var status = true;
  var status1 = true;
  var status2 = true;

  bool downloading = false;

  String progress = '0';

  bool isDownloaded = false;

  String uri =
      'https://file-examples.com/wp-content/uploads/2017/10/file-example_PDF_1MB.pdf'; // url of the file to be downloaded

  String filename = 'Agreement.pdf';

  Future<void> downloadFile(uri, fileName) async {
    setState(() {
      downloading = true;
    });

    String savePath = await getFilePath(fileName);

    Dio dio = Dio();

    dio.download(
      uri,
      savePath,
      onReceiveProgress: (rcv, total) {
        setState(() {
          progress = ((rcv / total) * 100).toStringAsFixed(0);
        });

        if (progress == '100') {
          setState(() {
            isDownloaded = true;
          });
        } else if (double.parse(progress) < 100) {}
      },
      deleteOnError: true,
    ).then((_) {
      setState(() {
        if (progress == '100') {
          isDownloaded = true;

          showToast('Tenancy Agreement saved to files !');
        }

        downloading = false;
      });
    }).catchError((e) {
      setState(() {
        downloading = false;
      });
    });
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    var dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName.pdf';

    return path;
  }

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
                    children: [SizedBox(
                      height: 20.h,
                    ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PendingBookings()));
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
                              Text(
                                ' Pending Bookings',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(Icons.arrow_forward_ios, size: 20, color: Theme.of(context).primaryColor,),
                            ],
                          ),
                        ),
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
                            ' Notification Settings',
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
                      Container(
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
                            Text(
                              ' Payment Notifications',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            FlutterSwitch(
                              width: 50.0.w,
                              height: 30.0.h,
                              valueFontSize: 25.0,
                              toggleSize: 20.0.r,
                              value: status2,
                              borderRadius: 30.0,
                              padding: 2.0,
                              activeColor: Theme.of(context).primaryColor,
                              onToggle: (val) {
                                setState(() {
                                  status2 = val;
                                });
                              },
                            ),
                          ],
                        ),
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
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' Email Notifications',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            FlutterSwitch(
                              width: 50.0.w,
                              height: 30.0.h,
                              valueFontSize: 25.0,
                              toggleSize: 20.0.r,
                              value: status1,
                              borderRadius: 30.0,
                              padding: 2.0,
                              activeColor: Theme.of(context).primaryColor,
                              onToggle: (val) {
                                setState(() {
                                  status1 = val;
                                });
                              },
                            ),
                          ],
                        ),
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
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' Announcements Notifications',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            FlutterSwitch(
                              width: 50.0.w,
                              height: 30.0.h,
                              valueFontSize: 25.0,
                              toggleSize: 20.0.r,
                              value: status,
                              borderRadius: 30.0,
                              padding: 2.0,
                              activeColor: Theme.of(context).primaryColor,
                              onToggle: (val) {
                                setState(() {
                                  status = val;
                                });
                              },
                            ),
                          ],
                        ),
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
                            ' Tenant Agreement',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      downloading == false
                          ? GestureDetector(
                              onTap: () {
                                var units = Provider.of<UnitProvider>(context,
                                    listen: false);

                                if (units.bookingList
                                        .where(
                                            (b) => b.bookBy == user.user!.uid)
                                        .length >
                                    0) {
                                  if (units.bookingList
                                      .where((b) => b.bookBy == user.user!.uid)
                                      .first
                                      .agreement!
                                      .isNotEmpty) {
                                    downloadFile(
                                        units.bookingList
                                            .where((b) =>
                                                b.bookBy == user.user!.uid)
                                            .first
                                            .agreement!,
                                        filename);
                                  }
                                }else{
                                  showToast('No room still booked !');
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.all(18.h),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 50.h,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ImageIcon(
                                        AssetImage('assets/images/down.png'),
                                        size: 200.w,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: 20.h, bottom: 25.h),
                              child: CircularProgressIndicator(),
                            ),
                      GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance
                              .signOut()
                              .then((value) async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.setBool('login', false);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 18.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 50.h,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                Text(
                                  ' Logout',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
