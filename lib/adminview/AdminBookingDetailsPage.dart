import 'package:barleryroof/Views/RequestApplyPage.dart';
import 'package:barleryroof/constant.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/request_model.dart';

class AdminBookingdetailsPage extends StatefulWidget {
  AdminBookingdetailsPage({Key? key, this.request}) : super(key: key);
  RequestModel? request;
  @override
  State<AdminBookingdetailsPage> createState() => _AdminBookingdetailsPageState();
}

class _AdminBookingdetailsPageState extends State<AdminBookingdetailsPage> {
  var visible = true;
  var initStatus = true;

  var responseByAdminController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    // FirebaseFirestore.instance.collection('Requests').doc(widget.id).get().then((value) {
    //   setState(() {
    //     initStatus = value['step'] == 2 ? true : false;
    //   });
    // });
  }

  TextEditingController detail = new TextEditingController();
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text(
                                'Requests',
                                style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.transparent,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            Padding(
                padding: EdgeInsets.all(20.h),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      '${widget.request!.title}',
                                      style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.68,
                                child: Text(
                                  'Submitted on ${widget.request!.date}',
                                  style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10.r)),
                                  padding: EdgeInsets.all(10.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 30.h,
                                            width: 30.h,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(image: NetworkImage('${user.usersList.where((u) => u.uid == widget.request!.createdById).first.profilePicture}'), fit: BoxFit.fill)),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ' ${user.usersList.where((u) => u.uid == widget.request!.createdById).first.name}',
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
                                                    ' ${user.usersList.where((u) => u.uid == widget.request!.createdById).first.nationality}',
                                                    style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      // Column(
                                      //   children: [
                                      //     Text(
                                      //       ' \$150k',
                                      //       style:
                                      //       GoogleFonts.nunitoSans(color: Theme.of(context).primaryColor, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                      //     ),
                                      //     Text(
                                      //       ' In 3 days',
                                      //       style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: widget.request!.step! >= 1
                                  ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 30.r,
                              )
                                  : Icon(
                                Icons.circle,
                                color: Colors.black,
                                size: 30.r,
                              ),
                            ),
                            Container(
                              height: !visible ? 200.h : 150.h,
                              child: DottedLine(
                                direction: Axis.vertical,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Step 1 of 5',
                              style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Request Submitted',
                              style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                '${widget.request!.description}',
                                style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: widget.request!.step! >= 2
                                  ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 30.r,
                              )
                                  : Icon(
                                Icons.circle,
                                color: widget.request!.step! < 2 && widget.request!.closed == true ? Colors.red : Colors.black,
                                size: 30.r,
                              ),
                            ),
                            Container(
                              height: !visible ? 200.h : 150.h,
                              child: DottedLine(
                                direction: Axis.vertical,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Step 2 of 5',
                              style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Admin Looking at the matter',
                              style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                '${widget.request!.description}',
                                style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: widget.request!.step! >= 3
                                  ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 30.r,
                              )
                                  : Icon(
                                Icons.circle,
                                color: widget.request!.step! < 3 && widget.request!.closed == true ? Colors.red : Colors.black,
                                size: 30.r,
                              ),
                            ),
                            Container(
                              height: !visible ? 200.h : 150.h,
                              child: DottedLine(
                                direction: Axis.vertical,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Step 3 of 5',
                                    style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Initiate the process',
                                    style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                  ),
                                  Visibility(
                                    visible: !visible,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          height: 100.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10.r),
                                          ),
                                          padding: EdgeInsets.all(10.h),
                                          margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Issue Details',
                                                    style: GoogleFonts.nunitoSans(
                                                        color: Theme.of(context).primaryColor, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: 20.h,
                                                    child: TextFormField(
                                                      controller: detail,
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(borderSide: BorderSide.none),
                                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                                        hintText: 'Enter here',
                                                        contentPadding: EdgeInsets.symmetric(vertical: 2),
                                                        hintStyle: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                                      ),
                                                      maxLines: 20,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    if (detail.text.isEmpty) {
                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                          content: Text(
                                                            'Please Enter detail',
                                                            style: TextStyle(color: Colors.white),
                                                          )));
                                                    } else {
                                                      await user.updateRequest(widget.request!.uid, {'step': '4', 'responseAdmin': detail.text});
                                                      // FirebaseFirestore.instance.collection('Requests').doc(widget.id).update({
                                                      //   'status': 'Step 4 of 5 (Admin initiated the process and is under process)',
                                                      //   'step': 4,
                                                      //   'responseByAdmin': '${detail.text}'
                                                      // });
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Initiated',
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                          backgroundColor: Colors.green,
                                                        ),
                                                      );
                                                      setState(() {
                                                        visible = true;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                    height: 40.h,
                                                    child: Center(
                                                      child: Text(
                                                        'Done',
                                                        style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5.w,),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      visible = true;
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                    height: 40.h,
                                                    child: Center(
                                                      child: Text(
                                                        'Cancel',
                                                        style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: visible,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      visible = false;
                                    });
                                  },
                                  child: Visibility(
                                    visible: initStatus && widget.request!.closed == false && widget.request!.step! == 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                                      height: 40.h,
                                      child: Center(
                                        child: Text(
                                          'Initiate',
                                          style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: widget.request!.step! >= 4
                                  ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 30.r,
                              )
                                  : Icon(
                                Icons.circle,
                                color: widget.request!.step! < 4 && widget.request!.closed == true ? Colors.red : Colors.black,
                                size: 30.r,
                              ),
                            ),
                            Container(
                              height: !visible ? 200.h : 150.h,
                              child: DottedLine(
                                direction: Axis.vertical,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Step 4 of 5',
                              style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Under Process',
                              style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                            ),
                            // Container(
                            //   width: MediaQuery.of(context).size.width*0.7,
                            //   child: Text(
                            //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra ridiculus odio odio turpis velit. Sodales blandit cursus est non. In placerat eget maecenas feugiat sem.',
                            //     style: GoogleFonts.nunitoSans(
                            //         color: Colors.black,
                            //         fontSize: 12.sp,
                            //         fontWeight: FontWeight.w500),
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: widget.request!.step! >= 5
                                  ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 30.r,
                              )
                                  : Icon(
                                Icons.circle,
                                color: widget.request!.step! < 5 && widget.request!.closed == true ? Colors.red : Colors.black,
                                size: 30.r,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Step 5 of 5',
                              style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Request Resolved',
                              style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                            ),
                            // Container(
                            //   width: MediaQuery.of(context).size.width*0.7,
                            //   child: Text(
                            //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra ridiculus odio odio turpis velit. Sodales blandit cursus est non. In placerat eget maecenas feugiat sem.',
                            //     style: GoogleFonts.nunitoSans(
                            //         color: Colors.black,
                            //         fontSize: 12.sp,
                            //         fontWeight: FontWeight.w500),
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.request!.step! != 5 && widget.request!.closed == true
                            ? Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              // FirebaseFirestore.instance.collection('Requests').doc(widget.id).update({
                              //   'closed': false,
                              //   'responseByAdmin': responseByAdminController.text,
                              // });
                              await user.updateRequest(widget.request!.uid, {'responseAdmin': responseByAdminController.text, 'closed': false}).then((value) {
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Open Request',
                                  style: GoogleFonts.nunitoSans(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        )
                            : Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Reason for closing the request'),
                                      content: Container(
                                        height: 200.h,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: responseByAdminController,
                                              decoration: InputDecoration(
                                                hintText: 'Admin Response',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel')),
                                        TextButton(
                                            onPressed: () async {
                                              if (responseByAdminController.text.isEmpty) {
                                                Fluttertoast.showToast(msg: 'Please enter a response');
                                                return;
                                              }

                                              await user.updateRequest(widget.request!.uid, {'closed': true, 'responseAdmin': responseByAdminController.text}).then((value) {
                                                showToast('Request closed successfully !');
                                                Navigator.pop(context);
                                              }).catchError((e){

                                              });
                                            },
                                            child: Text('Close Request')),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 50.h,
                              child: Center(
                                child: Text(
                                  'Close Request',
                                  style: GoogleFonts.nunitoSans(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        // widget.request!.step! == 4
                        // ?
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await user.updateRequest(widget.request!.uid, {
                                'step': '5',
                                'closed': true
                              }).then((value) {
                                Navigator.pop(context);
                              });
                              // FirebaseFirestore.instance.collection('Requests').doc(widget.id).update({
                              //   'step': 5,
                              //   'closed': true,
                              // });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 50.h,
                              child: Center(
                                child: Text(
                                  'Mark as Done',
                                  style: GoogleFonts.nunitoSans(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        )
                        // : Container(),
                      ],
                    )
                  ],
                )),
            ],
          ),
        ),
      ),
    );
  }
}
