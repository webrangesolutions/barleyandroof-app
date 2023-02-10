import 'package:barleryroof/providers/unit_provider.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'RoomDetailsPage.dart';

class AllRoomsPage extends StatefulWidget {
  const AllRoomsPage({Key? key}) : super(key: key);

  @override
  State<AllRoomsPage> createState() => _AllRoomsPageState();
}

class _AllRoomsPageState extends State<AllRoomsPage> {
  var status = true;
  var status1 = true;
  var status2 = true;
  var logined = false;
  GetLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = await pref.getBool('login');
    if (data == true) {
      setState(() {
        logined = true;
      });
    }
  }

  @override
  void initState() {
    GetLogin();
    // TODO: implement initState
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
            unit.bookingList.length > 0 ?
            Container(
              height: MediaQuery.of(context).size.height * 0.87,
              child: ListView.builder(
                  itemCount: unit.unitList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (_) => RoomDetailsPage(
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
                                  borderRadius:
                                  BorderRadius.circular(20),
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
                                  user.user!.name == 'Admin' ?
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        FirebaseFirestore.instance
                                            .collection('Units')
                                            .doc(unit.unitList[index].uid)
                                            .delete();
                                      });
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
                                  ) : Container()
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${unit.unitList[index].title}',
                                        style: GoogleFonts
                                            .nunitoSans(
                                            color:
                                            Colors.black,
                                            fontSize: 20.sp,
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
                                            size: 20,
                                          ),
                                          Text(
                                            '${unit.unitList[index].street} ${unit.unitList[index].postalCode}',
                                            style: GoogleFonts
                                                .nunitoSans(
                                                color: Colors
                                                    .grey,
                                                fontSize:
                                                15.sp,
                                                fontWeight:
                                                FontWeight
                                                    .w500),
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
                                        style: GoogleFonts
                                            .nunitoSans(
                                            color: Theme.of(
                                                context)
                                                .primaryColor,
                                            fontSize: 15.sp,
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
                      ),
                    );
                  }
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
