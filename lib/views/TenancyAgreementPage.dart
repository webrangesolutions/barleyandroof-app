import 'dart:io';

import 'package:barleryroof/Views/BookPayment.dart';
import 'package:barleryroof/Views/BottomBar.dart';
import 'package:barleryroof/constant.dart';
import 'package:barleryroof/providers/unit_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../providers/user_provider.dart';
import 'BookingdetailsPage.dart';
import 'RoomDetailsPage.dart';

class TenancyAgreementPage extends StatefulWidget {
  Map<String, dynamic>? data;

  TenancyAgreementPage({Key? key, this.data}) : super(key: key);

  @override
  State<TenancyAgreementPage> createState() => _TenancyAgreementPageState();
}

class _TenancyAgreementPageState extends State<TenancyAgreementPage> {
  var status = true;
  var status1 = true;
  var status2 = true;
  var scroll = false;
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var units = Provider.of<UnitProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: user.isLoading == false
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: scroll
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
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
                                      'Tenancy Agreement',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox()
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.87,
                      child: SingleChildScrollView(
                          physics: scroll
                              ? NeverScrollableScrollPhysics()
                              : AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.all(20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select tenancy agreement document from your device or online drive.',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    var msg = await FilePicker.platform
                                        .pickFiles(
                                            type: FileType.image,
                                            allowMultiple: false);

                                    setState(() {
                                      result = msg;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 50.h,
                                    margin: EdgeInsets.only(top: 30.h),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ImageIcon(
                                            AssetImage('assets/images/map.png'),
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            ' Select Tenancy Agreement',
                                            style: GoogleFonts.nunitoSans(
                                                color: Colors.black,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                result != null && result!.files.length > 0
                                    ? Container(
                                        margin: EdgeInsets.only(top: 20.h),
                                        child: Wrap(
                                          spacing: 8,
                                          runSpacing: 5,
                                          children: result!.files.map((file) {
                                            return Container(
                                              height: 120.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          File(file.path!)),
                                                      fit: BoxFit.cover)),
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 10.h,
                                ),
                                GestureDetector(
                                  onTap: () async {

                                    if (result == null) {
                                      showToast(
                                          'Select Tenancy Agreement document !');
                                    } else {
                                      user.setIsLoading(true);

                                      result!.files.forEach((f) async {
                                        var id = getRandomString(5);
                                        var data = {
                                          'id': id,
                                          'fileName': DateTime.now()
                                              .microsecondsSinceEpoch
                                              .toString(),
                                          'file': File(f.path!),
                                        };

                                        await units
                                            .postUnitStorage(
                                                'bookings/agreements', data)
                                            .then((url) {
                                          widget.data!
                                              .addAll({'agreement': url});

                                          Future.delayed(Duration(seconds: 3))
                                              .then((value) async {
                                            if (widget.data!['status'] ==
                                                'Payment Not Done') {
                                              widget.data!.addAll({
                                                'uid': widget.data!['uid'],
                                                'bookBy': user.user!.uid,
                                                'step': 2,
                                                'status': 'Payment Done',
                                                'reason': '',
                                                'paymentDate':
                                                    '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                              });

                                              await updateBooking(widget.data);
                                            } else {
                                              var id = getRandomString(28);

                                              widget.data!.addAll({
                                                'uid': id,
                                                'bookBy': user.user!.uid,
                                                'step': 2,
                                                'status': 'Payment Done',
                                                'reason': '',
                                                'paymentDate':
                                                    '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                              });

                                              await postBooking(widget.data);
                                            }
                                          });
                                        });
                                      });
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 50.h,
                                    child: Center(
                                      child: Text(
                                        'Next',
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
            )
          : LoadingWidget(context),
    );
  }

  postBooking(data) async {
    var user = Provider.of<UserProvider>(context, listen: false);
    var units = Provider.of<UnitProvider>(context, listen: false);

    await units.postUnitBooking(data).then((value) async {
      user.setIsLoading(false);

      if (value['success'] == true) {
        showToast('Submitted successfully');

        await user.updateUser(user.user!.uid, {
          'paymentHistory': FieldValue.arrayUnion([
            {
              'amount': '${widget.data!['payment']}',
              'date': '${widget.data!['paymentDate']}',
              'detail': 'Booking Deposit',
              'bookingId': widget.data!['uid']
            }
          ])
        });
        await units.updateUnit(widget.data!['unitId'], {
          'tenants': FieldValue.arrayUnion([widget.data!['bookBy']])
        });
        await user.fetchUserById(user.user!.uid);
        finalDialog();
      } else {
        showToast('Submission failed !');
      }
    }).catchError((e) {
      user.setIsLoading(false);
      showToast('Submission failed !');
    });
  }

  updateBooking(data) async {
    var user = Provider.of<UserProvider>(context, listen: false);
    var units = Provider.of<UnitProvider>(context, listen: false);

    await units.updateBooking(data['uid'], data).then((value) async {
      user.setIsLoading(false);

      if (value['success'] == true) {
        showToast('Submitted successfully');

        await user.updateUser(user.user!.uid, {
          'paymentHistory': FieldValue.arrayUnion([
            {
              'amount': '${widget.data!['payment']}',
              'date': '${widget.data!['paymentDate']}',
              'detail': 'Booking Deposit',
              'bookingId': widget.data!['uid']
            }
          ])
        });
        await units.updateUnit(widget.data!['unitId'], {
          'tenants': FieldValue.arrayUnion([widget.data!['bookBy']])
        });
        await user.fetchUserById(user.user!.uid);
        finalDialog();
      } else {
        showToast('Submission failed !');
      }
    }).catchError((e) {
      user.setIsLoading(false);
      showToast('Submission failed !');
    });
  }

  finalDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Container(
                  height: 350.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 350.h,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Booking Done',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Please make payment based on the payment detail. After payment is made, please go to My Payment to upload the proof of payment. Admin will review and verify the documents and payment. Once the admin complete the verification, Tenancy Agreement will be sent over via Email for review and signing.',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => BottomBarPage()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 50.h,
                                child: Center(
                                  child: Text(
                                    'Done',
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
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 10)
                        ]),
                    padding: EdgeInsets.all(10.r),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 60.r,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
////////
//old tenancy agreement

// class TenancyAgreementPage extends StatefulWidget {
//   Map<String, dynamic>? data;
//
//   TenancyAgreementPage({Key? key, this.data}) : super(key: key);
//
//   @override
//   State<TenancyAgreementPage> createState() => _TenancyAgreementPageState();
// }
//
// class _TenancyAgreementPageState extends State<TenancyAgreementPage> {
//   var status = true;
//   var status1 = true;
//   var status2 = true;
//   var scroll = false;
//   GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     var user = Provider.of<UserProvider>(context);
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       body: user.isLoading == false ?
//       Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           physics: scroll
//               ? NeverScrollableScrollPhysics()
//               : AlwaysScrollableScrollPhysics(),
//           child: Column(
//             children: [
//               Container(
//                 height: 100,
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.white,
//                 padding: EdgeInsets.all(10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: Icon(
//                               Icons.arrow_back_outlined,
//                               color: Colors.black,
//                               size: 30,
//                             )),
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                           ),
//                           padding: EdgeInsets.all(5),
//                           child: Row(
//                             children: [
//                               Text(
//                                 'Tenancy Agreement',
//                                 style: GoogleFonts.nunitoSans(
//                                     color: Colors.black,
//                                     fontSize: 20.sp,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox()
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.87,
//                 child: SingleChildScrollView(
//                     physics: scroll
//                         ? NeverScrollableScrollPhysics()
//                         : AlwaysScrollableScrollPhysics(),
//                     child: Padding(
//                       padding: EdgeInsets.all(20.h),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 'Tenancy Agreement',
//                                 style: GoogleFonts.nunitoSans(
//                                     color: Colors.black,
//                                     fontSize: 20.sp,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width,
//                             child: Text(
//                               'I confirm that booking deposit is non- refundable. The booking deposit will be '
//                                   'forfeited for any withdrawal of the application for whatsoever reasons. The booking fee '
//                                   'is transferable to another Unit under Barley and Roof with a validity of maximum 7 '
//                                   'days.Please ensure the details filled or documents uploaded are correct as an amendment'
//                                   ' fee of \$10 will be charged for any amendment.After payment is made, please go to My Payment to upload the proof of payment. Admin will review and verify the documents and payment. Once the admin complete the verification, Tenancy Agreement will be sent over via Email for review and signing.',
//                               style: GoogleFonts.nunitoSans(
//                                   color: Colors.grey,
//                                   fontSize: 15.sp,
//                                   fontWeight: FontWeight.w500),
//                               maxLines: 100,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 child: SfSignaturePad(
//                                   key: _signaturePadKey,
//                                   backgroundColor: Colors.white,
//                                 ),
//                                 height: 200,
//                                 width: MediaQuery.of(context).size.width * 0.9,
//                               ),
//                             ],
//                           ),
//                           GestureDetector(
//                             child: Container(
//                               width: MediaQuery.of(context).size.width * 0.9,
//                               padding: EdgeInsets.symmetric(horizontal: 30),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                               ),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     'Sign here',
//                                     style: GoogleFonts.nunitoSans(
//                                         color: Colors.black,
//                                         fontSize: 15.sp,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                           'Press to ${scroll ? 'Unlock' : 'Lock'} scroll '),
//                                       IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               scroll = !scroll;
//                                             });
//                                           },
//                                           icon: scroll
//                                               ? Icon(Icons.lock_open)
//                                               : Icon(Icons.lock_outline))
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           GestureDetector(
//                             onTap: () async {
//                               var id = getRandomString(28);
//                               widget.data!.addAll({
//                                 'uid': id,
//                                 'bookBy': user.user!.uid,
//                                 'step': 2,
//                                 'status': 'Payment Done',
//                                 'reason': '',
//                                 'paymentDate': '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
//                               });
//                               await postBooking(widget.data);
//
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context).primaryColor,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               height: 50.h,
//                               child: Center(
//                                 child: Text(
//                                   'Next',
//                                   style: GoogleFonts.nunitoSans(
//                                       color: Colors.black,
//                                       fontSize: 15.sp,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),
//               ),
//             ],
//           ),
//         ),
//       ) : LoadingWidget(context),
//     );
//   }
//
//   postBooking(data) async {
//     var user = Provider.of<UserProvider>(context, listen: false);
//     var units = Provider.of<UnitProvider>(context, listen: false);
//
//     user.setIsLoading(true);
//
//     await units.postUnitBooking(data).then((value) async {
//       user.setIsLoading(false);
//
//       if (value['success'] == true) {
//         showToast('Submitted successfully');
//
//         await user.updateUser(user.user!.uid, {
//           'paymentHistory': FieldValue.arrayUnion([
//             {
//               'amount': '${widget.data!['payment']}',
//               'date': '${widget.data!['paymentDate']}',
//               'detail': 'Booking Deposit',
//               'bookingId': widget.data!['uid']
//             }
//           ])
//         });
//         await units.updateUnit(widget.data!['unitId'], {'tenants': FieldValue.arrayUnion([widget.data!['bookBy']])});
//         await user.fetchUserById(user.user!.uid);
//         finalDialog();
//       } else {
//         showToast('Submission failed !');
//       }
//     }).catchError((e) {
//       user.setIsLoading(false);
//       showToast('Submission failed !');
//     });
//   }
//
//   finalDialog() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return Dialog(
//             backgroundColor: Colors.transparent,
//             child: Stack(
//               children: [
//                 Container(
//                   height: 350.h,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: 350.h,
//                         padding: EdgeInsets.all(20.w),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10.r)),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text(
//                               'Booking Done',
//                               style: GoogleFonts.nunitoSans(
//                                   color: Colors.black,
//                                   fontSize: 15.sp,
//                                   fontWeight: FontWeight.w700),
//                             ),
//                             Text(
//                               'Please make payment based on the payment detail. After payment is made, please go to My Payment to upload the proof of payment. Admin will review and verify the documents and payment. Once the admin complete the verification, Tenancy Agreement will be sent over via Email for review and signing.',
//                               style: GoogleFonts.nunitoSans(
//                                   color: Colors.grey,
//                                   fontSize: 12.sp,
//                                   fontWeight: FontWeight.w700),
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(
//                               height: 20.h,
//                             ),
//                             GestureDetector(
//                               onTap: () async {
//                                 Navigator.of(context).pushReplacement(
//                                     MaterialPageRoute(
//                                         builder: (_) => BottomBarPage()));
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).primaryColor,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 height: 50.h,
//                                 child: Center(
//                                   child: Text(
//                                     'Done',
//                                     style: GoogleFonts.nunitoSans(
//                                         color: Colors.black,
//                                         fontSize: 15.sp,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: 10,
//                   left: 10,
//                   right: 10,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.black26,
//                               spreadRadius: 1,
//                               blurRadius: 10)
//                         ]),
//                     padding: EdgeInsets.all(10.r),
//                     child: Icon(
//                       Icons.check_circle,
//                       color: Colors.green,
//                       size: 60.r,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         });
//   }
// }
