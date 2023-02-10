import 'dart:io';

import 'package:barleryroof/providers/unit_provider.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../widgets/custom_txtfield.dart';

class AddPayment extends StatefulWidget {
  AddPayment({Key? key}) : super(key: key);

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  final amountTxt = TextEditingController();
  final dateTxt = TextEditingController();
  final descTxt = TextEditingController();

  String name = '', unit = '', room = '', paymentType = 'Repair Work';
  List<String> rooms = [];

  FilePickerResult? result;

  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false);
    var units = Provider.of<UnitProvider>(context, listen: false);
    setState(() {
      unit = units.unitList[0].title!;
      if (units.unitList.where((u) => u.title == unit).first.tenants!.length >
              0 &&
          user.usersList
                  .where((u) =>
                      u.uid ==
                      units.unitList
                          .where((u) => u.title == unit)
                          .first
                          .tenants![0])
                  .length >
              0) {
        name = user.usersList
            .where((u) =>
                u.uid ==
                units.unitList.where((u) => u.title == unit).first.tenants![0])
            .first
            .name!;
      }

      units.unitList.where((u) => u.title == unit).first.rooms!.forEach((r) {
        rooms.add(r['title']);
      });
      if (rooms.length > 0) {
        room = rooms[0];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var units = Provider.of<UnitProvider>(context);

    return Scaffold(
      body: user.isLoading == false
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.black,
                              size: 30,
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add Payment',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'Please enter your details',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 10.h, left: 20.w, right: 20.w, top: 30.h),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Unit',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 20,
                                child: DropdownButton(
                                  value: unit,
                                  onChanged: (val) {
                                    setState(() {
                                      unit = val!;

                                      name = user.usersList
                                          .where((u) =>
                                      u.uid ==
                                          units.unitList.where((u) => u.title == unit).first.tenants![0])
                                          .first
                                          .name!;
                                    });
                                  },
                                  items: units.unitList
                                      .map((u) => DropdownMenuItem(
                                          value: u.title,
                                          child: Text('${u.title}')))
                                      .toList(),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 10.h, left: 20.w, right: 20.w),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Room',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              rooms.length > 0
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: 20,
                                      child: DropdownButton(
                                        value: room,
                                        onChanged: (val) {
                                          setState(() {
                                            room = val!;
                                          });
                                        },
                                        items: rooms
                                            .map((r) => DropdownMenuItem(
                                                value: r, child: Text('${r}')))
                                            .toList(),
                                      ),
                                    )
                                  : Container()
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 10.h, left: 20.w, right: 20.w),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select User',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              units.unitList
                                  .where((u) => u.title == unit)
                                  .first
                                  .tenants!
                                  .length >
                                  0 &&
                                  user.usersList
                                      .where((u) =>
                                  u.uid ==
                                      units.unitList
                                          .where((u) =>
                                      u.title == unit)
                                          .first
                                          .tenants![0])
                                      .length >
                                      0
                                  ? Container(
                                width: MediaQuery.of(context).size.width *
                                    0.5,
                                height: 20,
                                child: DropdownButton(
                                  value: name,
                                  onChanged: (val) {
                                    print(val);
                                    if (units.unitList
                                        .where((u) =>
                                    u.title == unit)
                                        .first
                                        .tenants!
                                        .length >
                                        0 &&
                                        user.usersList
                                            .where((u) =>
                                        u.uid ==
                                            units.unitList
                                                .where((u) =>
                                            u.title ==
                                                unit)
                                                .first
                                                .tenants![0])
                                            .length >
                                            0) {
                                      setState(() {
                                        name = val!;
                                      });
                                    }
                                  },
                                  items: units.unitList
                                      .where((u) => u.title == unit)
                                      .first
                                      .tenants!
                                      .map((u) => DropdownMenuItem(
                                      value: user.usersList
                                          .where((us) => us.uid == u)
                                          .first
                                          .name,
                                      child: Text(
                                          '${user.usersList.where((us) => us.uid == u).first.name}')))
                                      .toList(),
                                ),
                              )
                                  : Container(
                                width: MediaQuery.of(context).size.width *
                                    0.5,
                                height: 20,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: 'No tenants in room',
                                    enabled: false,
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 2),
                                    hintStyle: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 10.h, left: 20.w, right: 20.w),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select User',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              units.unitList
                                  .where((u) => u.title == unit)
                                  .first
                                  .tenants!
                                  .length >
                                  0 &&
                                  user.usersList
                                      .where((u) =>
                                  u.uid ==
                                      units.unitList
                                          .where((u) =>
                                      u.title == unit)
                                          .first
                                          .tenants![0])
                                      .length >
                                      0
                                  ? Container(
                                width: MediaQuery.of(context).size.width *
                                    0.5,
                                height: 20,
                                child: DropdownButton(
                                  value: name,
                                  onChanged: (val) {
                                    print(val);
                                    if (units.unitList
                                        .where((u) =>
                                    u.title == unit)
                                        .first
                                        .tenants!
                                        .length >
                                        0 &&
                                        user.usersList
                                            .where((u) =>
                                        u.uid ==
                                            units.unitList
                                                .where((u) =>
                                            u.title ==
                                                unit)
                                                .first
                                                .tenants![0])
                                            .length >
                                            0) {
                                      setState(() {
                                        name = val!;
                                      });
                                    }
                                  },
                                  items: units.unitList
                                      .where((u) => u.title == unit)
                                      .first
                                      .tenants!
                                      .map((u) => DropdownMenuItem(
                                      value: user.usersList
                                          .where((us) => us.uid == u)
                                          .first
                                          .name,
                                      child: Text(
                                          '${user.usersList.where((us) => us.uid == u).first.name}')))
                                      .toList(),
                                ),
                              )
                                  : Container(
                                width: MediaQuery.of(context).size.width *
                                    0.5,
                                height: 20,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: 'No tenants in room',
                                    enabled: false,
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 2),
                                    hintStyle: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 10.h, left: 20.w, right: 20.w),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.title,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Type',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 20,
                                child: DropdownButton(
                                  value: paymentType,
                                  onChanged: (val) {
                                    setState(() {
                                      paymentType = val!;
                                    });
                                  },
                                  items: ['Repair Work', 'Aircon Overused']
                                      .map((v) => DropdownMenuItem(
                                          value: v, child: Text('${v}')))
                                      .toList(),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 10.h,
                        left: 20.w,
                        right: 20.w,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter Amount',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 20,
                                child: TextFormField(
                                  controller: amountTxt,
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
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000));
                        dateTxt.text =
                            '${dateTime!.day}-${dateTime.month}-${dateTime.year}';
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 10.h,
                          left: 20.w,
                          right: 20.w,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.grey, width: 1)),
                        padding: EdgeInsets.all(10.h),
                        child: Row(
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Due Date',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: 20,
                                  child: TextFormField(
                                    controller: dateTxt,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabled: false,
                                      hintText: 'Due Date',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 10.h,
                        left: 20.w,
                        right: 20.w,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey, width: 1)),
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Remark',
                                style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 20,
                                child: TextFormField(
                                  controller: descTxt,
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
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var msg = await FilePicker.platform
                            .pickFiles(type: FileType.image);

                        setState(() {
                          result = msg;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 10.h,
                          left: 20.w,
                          right: 20.w,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.grey, width: 1)),
                        padding: EdgeInsets.all(10.h),
                        child: Row(
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Invoice',
                                  style: GoogleFonts.nunitoSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 20,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: 'Select file (PDF, PNG, JPEG)',
                                      enabled: false,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    result != null && result!.files.length > 0
                        ? Container(
                            margin: EdgeInsets.only(
                                top: 20.h, left: 15.w, right: 15.w),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 5,
                              children: result!.files.map((file) {
                                return Container(
                                  height: 140.h,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      image: DecorationImage(
                                          image: FileImage(File(file.path!)),
                                          fit: BoxFit.cover)),
                                );
                              }).toList(),
                            ),
                          )
                        : Container(),
                    GestureDetector(
                      onTap: () async {
                        var data1 = {
                          'amount': amountTxt.text,
                          'date': dateTxt.text,
                          'remark': descTxt.text,
                          'bookingId': ''
                        };

                        if (result == null) {
                          showToast('Select Invoice');
                        } else {
                          user.setIsLoading(true);

                          var id = getRandomString(28);
                          var data2 = {
                            'uid': id,
                            'unitTitle': unit,
                            'roomTitle': unit,
                            'selectedUser': name,
                            'paymentType': paymentType,
                            'amount': amountTxt.text,
                            'dueDate': dateTxt.text,
                            'remark': descTxt.text,
                            'invoice': ''
                          };

                          result!.files.forEach((f) async {
                            var id = getRandomString(5);
                            var data = {
                              'id': id,
                              'fileName': File(f.path!.split('/').last),
                              'file': File(f.path!),
                            };

                            await units
                                .postUnitStorage('units/payments', data)
                                .then((url) {
                              data2.addAll({'invoice': url});
                            });
                          });

                          Future.delayed(Duration(seconds: 3))
                              .then((value) async {
                            await units.postPayments(data2).then((value) async {
                              await user.updateUser(
                                  user.usersList
                                      .where((us) => us.name == name)
                                      .first
                                      .uid,
                                  {
                                    'paymentHistory':
                                        FieldValue.arrayUnion([data1])
                                  });
                              user.setIsLoading(false);
                              showToast('Payment added successfully');
                              Navigator.pop(context);
                            });
                          });
                        }

                        // print(data);
                        // if (amountTxt.text.isEmpty) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(content: Text('Please enter price')));
                        // } else if(descTxt.text.isEmpty){
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(content: Text('Please enter description')));
                        // } else {
                        //   var data = {
                        //     'amount' : amountTxt.text,
                        //     'date' : '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                        //     'detail' : descTxt.text,
                        //   };
                        //
                        //   user.setIsLoading(true);
                        //   await user.updateUser(user.usersList.where((u) => u.name == name).first.uid!, {'paymentHistory': FieldValue.arrayUnion([data])}).then((value) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //         SnackBar(content: Text('Payment added successfully to selected user')));
                        //     user.fetchAllUser();
                        //   user.setIsLoading(false);
                        //     Navigator.pop(context);
                        //   });
                        // }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50.h,
                        margin:
                            EdgeInsets.only(top: 30, left: 20.w, right: 20.w),
                        child: Center(
                          child: Text(
                            'Add',
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
            )
          : LoadingWidget(context),
    );
  }
}
