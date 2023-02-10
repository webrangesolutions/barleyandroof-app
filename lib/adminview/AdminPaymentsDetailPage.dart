import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AdminPaymentDetailPage extends StatefulWidget {
  AdminPaymentDetailPage({Key? key, this.data}) : super(key: key);

  var data;

  @override
  State<AdminPaymentDetailPage> createState() => _AdminPaymentDetailPageState();
}

class _AdminPaymentDetailPageState extends State<AdminPaymentDetailPage> {
  var status = true;
  var status1 = true;
  var status2 = true;

  final date = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text(
                                'Payment',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.87,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          padding: EdgeInsets.all(10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(widget.data['id'])
                                          .snapshots(),
                                      builder: (ctx, spt) {
                                        if (!spt.hasData) {
                                          return Container();
                                        } else {
                                          return Container(
                                            height: 30.h,
                                            width: 30.h,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        '${spt.data!['image']}'),
                                                    fit: BoxFit.fill)),
                                          );
                                        }
                                      }),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(widget.data['id'])
                                              .snapshots(),
                                          builder: (ctx, spt) {
                                            if (!spt.hasData) {
                                              return Container();
                                            } else {
                                              return Text(
                                                ' ${spt.data!['name']}',
                                                style: GoogleFonts.nunitoSans(
                                                    color: Colors.black,
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              );
                                            }
                                          }),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 20.w,
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('Units')
                                                  .doc(widget.data['roomId'])
                                                  .snapshots(),
                                              builder: (ctx, spt) {
                                                if (!spt.hasData) {
                                                  return Container();
                                                } else {
                                                  return Text(
                                                    ' ${spt.data!['title']}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                            color: Colors.grey,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  );
                                                }
                                              }),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    ' \$${widget.data['price']}',
                                    style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    ' In ${DateFormat("dd-MM-yyyy").parse((widget.data["period"])).difference(DateTime.now()).inDays} days',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.grey,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Mark Payment as Paid',
                            style: GoogleFonts.nunitoSans(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Please enter details',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              padding: EdgeInsets.all(10.h),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      var dateTime = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(3000));
                                      date.text =
                                          '${dateTime!.day}-${dateTime.month}-${dateTime.year}';
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Select Date of the Payment Received',
                                          style: GoogleFonts.nunitoSans(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: 20,
                                          child: TextFormField(
                                            controller: date,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: 'DD MM YYYY',
                                              enabled: false,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 2),
                                              hintStyle: GoogleFonts.nunitoSans(
                                                  color: Colors.black,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.all(10.h),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: 20.h,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: 'Enter here',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    maxLines: 20,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var d = DateTime(
                              int.parse(date.text.split('-')[2]),
                              int.parse(date.text.split('-')[1]) + 1,
                              int.parse(date.text.split('-')[0]));

                          setState(() {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.transparent,
                                    child: Center(
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        color: Colors.transparent,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          });

                          await FirebaseFirestore.instance
                              .collection('Bookings')
                              .doc(widget.data.id)
                              .update({
                            'period': '${d.day}-${d.month}-${d.year}',
                            'dateApplied':                             DateTime(
                                int.parse(date.text.split('-')[2]),
                                int.parse(date.text.split('-')[1]) + 1,
                                int.parse(date.text.split('-')[0]))
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 50.h,
                          child: Center(
                            child: Text(
                              'Mark as Paid',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
