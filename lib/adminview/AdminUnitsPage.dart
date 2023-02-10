import 'package:barleryroof/Views/LoginPage.dart';
import 'package:barleryroof/adminview/AddPayment.dart';
import 'package:barleryroof/providers/unit_provider.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Views/RoomDetailsPage.dart';
import 'AddUnit.dart';

class AdminUnitsPage extends StatefulWidget {
  const AdminUnitsPage({Key? key}) : super(key: key);

  @override
  State<AdminUnitsPage> createState() => _AdminUnitsPageState();
}

class _AdminUnitsPageState extends State<AdminUnitsPage> {
  @override
  Widget build(BuildContext context) {
    var unit = Provider.of<UnitProvider>(context);
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
                                  user.user!.name!,
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
                        onTap: () async {
                          await FirebaseAuth.instance
                              .signOut()
                              .then((value) async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.setBool('login', false);
                            pref.setBool('admin', false);
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => LoginPage()));
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 40.h,
                              width: 40.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.logout,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              ' Logout',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0.w, vertical: 20.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddUnitPage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Add Units',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Icon(
                              Icons.add_circle,
                              color: Theme.of(context).primaryColor,
                              size: 25.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          'My Units',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    ListView.builder(
                        itemCount: unit.unitList.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => RoomDetailsPage(
                                        adminView: true,
                                        units: unit.unitList[index],
                                      )));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    width: 326.w,
                                    height: 180.h,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              spreadRadius: 1,
                                              blurRadius: 10)
                                        ],
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${unit.unitList[index].images![0]}'),
                                            fit: BoxFit.fill)),
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await FirebaseFirestore.instance
                                                .collection('Units')
                                                .doc(unit.unitList[index].uid)
                                                .delete();

                                            await unit.fetchAllUnits();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                shape: BoxShape.circle),
                                            padding: EdgeInsets.all(10),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${unit.unitList[index].title}',
                                              style: GoogleFonts.nunitoSans(
                                                  color: Colors.black,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  size: 20,
                                                ),
                                                Text(
                                                  '${unit.unitList[index].street} ${unit.unitList[index].postalCode}',
                                                  style: GoogleFonts.nunitoSans(
                                                      color: Colors.grey,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${unit.unitList[index].rooms!.length} Rooms',
                                              style: GoogleFonts.nunitoSans(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500),
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
                        }),
                  ],
                ),
              ),
            ),
            // My Units heading
          ],
        ),
      ),
    );
  }
}
