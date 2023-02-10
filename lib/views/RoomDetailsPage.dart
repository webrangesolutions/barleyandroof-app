import 'package:barleryroof/Views/BookRoomPage.dart';
import 'package:barleryroof/adminview/EditUnit.dart';
import 'package:barleryroof/constant.dart';
import 'package:barleryroof/models/unit_model.dart';
import 'package:barleryroof/providers/unit_provider.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RoomDetailsPage extends StatefulWidget {
  UnitModel? units;
  bool adminView;

  RoomDetailsPage({super.key, this.adminView = false, this.units});

  @override
  State<RoomDetailsPage> createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  var status = true;
  var status1 = true;
  var status2 = true;

  var room_selected = 1;

  var roomsList = [];

  @override
  void initState() {
    // widget.units!.rooms!.forEach((r) {
    //   roomsList.add({
    //     'uid': r['uid'],
    //     'price': r['price'],
    //     'priceDetail': r['priceDetail'],
    //     'select': false
    //   });
    // });
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
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 180.h,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: widget.units!.images!.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            return Container(
                              margin: EdgeInsets.all(20),
                              width: MediaQuery.of(context).size.width - 30,
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
                                          '${widget.units!.images![i]}'),
                                      fit: BoxFit.cover)),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.units!.title}',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Theme.of(context).primaryColor,
                                        size: 20,
                                      ),
                                      Text(
                                        '${widget.units!.street} ${widget.units!.postalCode}',
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.grey,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${widget.units!.rooms!.length} Rooms',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${user.user!.name == 'Admin' ? 'Rooms' : 'Select Room'}',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              var msg = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UnitRooms(
                                            roomsList: widget.units!.rooms,
                                          )));

                              if (msg != null && user.user!.name != 'Admin') {
                                setState(() {
                                  roomsList.clear();
                                  roomsList.add(msg);
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    user.user!.name == 'Admin'
                                        ? 'All Rooms'
                                        : 'Select Room',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          roomsList.length > 0
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(
                                        bottom: 10.h, top: 10.h),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 140.h,
                                          child: ListView.builder(
                                              itemCount:
                                                  roomsList[0]['images'].length,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              physics: BouncingScrollPhysics(),
                                              itemBuilder: (ctx, i) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              roomsList[0]
                                                                      ['images']
                                                                  [i]))),
                                                );
                                              }),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${roomsList[0]['title']}',
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                              Text(
                                                '\$ ${roomsList[0]['price']}/${roomsList[0]['priceDetail']}',
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0.h),
                child: Row(
                  children: [
                    Text(
                      'About Property',
                      style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: ReadMoreText(
                  '${widget.units!.remark}',
                  numLines: 4,
                  readMoreText: 'Read more',
                  readLessText: 'Read less',
                  readMoreIconColor: Theme.of(context).primaryColor,
                  style: TextStyle(color: Colors.grey),
                  readMoreTextStyle:
                      TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.h),
                child: Row(
                  children: [
                    Text(
                      'Facilities',
                      style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.units!.wifi!
                      ? Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10),
                              child: ImageIcon(
                                AssetImage('assets/images/Frame (1).png'),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Free Wifi',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      : Container(),
                  widget.units!.parking!
                      ? Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10),
                              child: ImageIcon(
                                AssetImage('assets/images/Frame (2).png'),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Parking',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      : Container(),
                  widget.units!.laundry!
                      ? Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10),
                              child: ImageIcon(
                                AssetImage('assets/images/Frame (3).png'),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Laundry',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      : Container(),
                  widget.units!.pool!
                      ? Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10),
                              child: ImageIcon(
                                AssetImage('assets/images/Frame (4).png'),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Pool',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20.h),
              //   child: StreamBuilder<QuerySnapshot>(
              //     stream: FirebaseFirestore.instance
              //         .collection('Units')
              //         .doc(widget.id)
              //         .collection('Tenants')
              //         .where(
              //       'room_selected',
              //       isEqualTo: room_selected,
              //     )
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData && snapshot.data!.docs.length > 0) {
              //         return ListView.builder(
              //           shrinkWrap: true,
              //           physics: NeverScrollableScrollPhysics(),
              //           itemCount: snapshot.data!.docs.length,
              //           itemBuilder: (context, index) {
              //             return Column(
              //               children: [
              //                 GestureDetector(
              //                   onTap: () {
              //                     // Navigator.push(
              //                     //   context,
              //                     //   MaterialPageRoute(
              //                     //     builder: (context) => TenantProfile(
              //                     //       id: snapshot.data!.docs[index]['user_id'],
              //                     //     ),
              //                     //   ),
              //                     // );
              //                   },
              //                   child: Container(
              //                     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              //                     decoration: BoxDecoration(
              //                       color: Colors.white,
              //                       borderRadius: BorderRadius.circular(10),
              //                     ),
              //                     child: ListTile(
              //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //                       leading: CircleAvatar(
              //                         backgroundImage: NetworkImage(snapshot.data!.docs[index]['user_image']),
              //                       ),
              //                       title: Text(
              //                         snapshot.data!.docs[index]['user_name'],
              //                         style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w700),
              //                       ),
              //                       subtitle: Row(
              //                         children: [
              //                           Icon(
              //                             Icons.location_on,
              //                             color: Theme.of(context).primaryColor,
              //                             size: 18,
              //                           ),
              //                           SizedBox(
              //                             width: 5,
              //                           ),
              //                           Text(
              //                             snapshot.data!.docs[index]['unit_title'].length > 20
              //                                 ? snapshot.data!.docs[index]['unit_title'].substring(0, 20) + '...'
              //                                 : snapshot.data!.docs[index]['unit_title'],
              //                             style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w700),
              //                           ),
              //                         ],
              //                       ),
              //                       trailing: Column(
              //                         crossAxisAlignment: CrossAxisAlignment.end,
              //                         children: [
              //                           Text(
              //                             "\$" + snapshot.data!.docs[index]['unit_price'].toString(),
              //                             style: GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
              //                           ),
              //                           Text(
              //                             'In ${DateFormat("dd-MM-yyyy").parse((snapshot.data!.docs[index]["period"])).difference(DateTime.now()).inDays} days',
              //                             style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 20,
              //                 ),
              //               ],
              //             );
              //           },
              //         );
              //       } else {
              //         return Center(
              //             child: Column(
              //               children: [
              //                 SizedBox(
              //                   height: 20,
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Text(
              //                     '',
              //                   ),
              //                 ),
              //               ],
              //             ));
              //       }
              //     },
              //   ),
              // )//replaced by below container
              widget.adminView
                  ? Container()
                  : Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            var units = Provider.of<UnitProvider>(context,
                                listen: false);
                            bool roomRented = false;

                            units.bookingList.forEach((b) {
                              if ((b.roomId == roomsList.first['uid']) &&
                                  (b.unitId == widget.units!.uid) &&
                                  (b.status != 'Rejected')) {
                                setState(() {
                                  roomRented = true;
                                });
                              }
                            });
                            if (roomRented == true) {
                              showToast('You already rented this room !');
                            } else if (roomsList.length < 1) {
                              showToast('Select Room');
                            } else {
                              var data = {
                                'roomId': roomsList.first['uid'],
                                'unitId': widget.units!.uid
                              };

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => BookRoomPage(data: data)));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50.h,
                            child: Center(
                              child: Text(
                                'Book Room',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ImagesScreen(
                                          Images: widget.units!.images,
                                        )));
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.only(left: 20.w, right: 10.w),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 50.h,
                                width: 50.h,
                                child: Center(
                                    child: ImageIcon(
                                  AssetImage('assets/images/map.png'),
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                var whatsapp = "${widget.units!.whatsup}";
                                var whatsappAndroid = Uri.parse(
                                    "https://wa.me/$whatsapp/?text=${Uri.parse("hi")}");
                                if (await canLaunchUrl(whatsappAndroid)) {
                                  await launchUrl(whatsappAndroid);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "WhatsApp is not installed on the device"),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.only(left: 10.w, right: 20.w),
                                decoration: BoxDecoration(
                                  color: Color(0xff00BB1E),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 50.h,
                                width: MediaQuery.of(context).size.width * 0.65,
                                padding: EdgeInsets.all(20),
                                child: Center(
                                    child: ImageIcon(
                                  AssetImage('assets/images/what.png'),
                                  size: 200.w,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 45,
        width: 45,
        child: user.user!.name == 'Admin'
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditUnitPage(
                                unit: widget.units,
                              )));
                },
                elevation: 0.0,
                child: Icon(
                  Icons.edit,
                  size: 20,
                ),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.black,
              )
            : Container(),
      ),
    );
  }
}

class ImagesScreen extends StatefulWidget {
  final Images;

  const ImagesScreen({Key? key, this.Images}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(
        msg: "Swipe left and right to view all images",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: false,
              initialPage: 0,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: widget.Images.map<Widget>((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Image.network(
                      i,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UnitRooms extends StatefulWidget {
  const UnitRooms({Key? key, this.roomsList}) : super(key: key);

  final List<dynamic>? roomsList;

  @override
  State<UnitRooms> createState() => _UnitRoomsState();
}

class _UnitRoomsState extends State<UnitRooms> {
  var selectedRoom = {};
  var rooms = [];

  @override
  void initState() {
    setState(() {
      widget.roomsList!.forEach((r) {
        rooms.add({'room': r, 'select': false});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              if (rooms
                                      .where((r) => r['select'] == true)
                                      .length >
                                  0) {
                                setState(() {
                                  selectedRoom = rooms
                                      .where((r) => r['select'] == true)
                                      .first['room'];
                                });
                              }

                              Navigator.pop(context, selectedRoom);
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
              rooms.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ListView.builder(
                          itemCount: rooms.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (rooms[index]['select'] == false) {
                                  setState(() {
                                    rooms[index]['select'] = true;
                                  });

                                  if (rooms
                                          .where((r) =>
                                              (r['select'] == true) &&
                                              (r['room']['title'] !=
                                                  rooms[index]['room']
                                                      ['title']))
                                          .length >
                                      0) {
                                    setState(() {
                                      rooms
                                          .where((r) =>
                                              (r['select'] == true) &&
                                              (r['room']['title'] !=
                                                  rooms[index]['room']
                                                      ['title']))
                                          .first['select'] = false;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    rooms[index]['select'] = false;
                                  });
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 140.h,
                                        child: ListView.builder(
                                            itemCount: rooms[index]['room']
                                                    ['images']
                                                .length,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (ctx, i) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            rooms[index]['room']
                                                                    ['images']
                                                                [i]))),
                                              );
                                            }),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: rooms[index]['select'] == false
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.4),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${rooms[index]['room']['title']}',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Text(
                                              '\$ ${rooms[index]['room']['price']}/${rooms[index]['room']['priceDetail']}',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
