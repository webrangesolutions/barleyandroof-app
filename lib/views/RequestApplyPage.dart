import 'package:barleryroof/Views/RequestAService.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_txtfield.dart';
import 'RoomDetailsPage.dart';

class RequestApplyPage extends StatefulWidget {
  const RequestApplyPage({Key? key}) : super(key: key);

  @override
  State<RequestApplyPage> createState() => _RequestApplyPageState();
}

class _RequestApplyPageState extends State<RequestApplyPage> {
  var status = true;
  var status1 = true;
  var status2 = true;
  TextEditingController title = new TextEditingController();
  TextEditingController detail = new TextEditingController();
  TextEditingController date = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: user.isLoading == false
          ? SingleChildScrollView(
              child: Container(
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
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Request Application',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Container()
                              // GestureDetector(
                              //     onTap: () {
                              //       Navigator.of(context).push(
                              //           MaterialPageRoute(
                              //               builder: (_) => RequestAService()));
                              //     },
                              //     child: Icon(
                              //       Icons.list_alt,
                              //       color: Colors.black,
                              //     ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.87,
                      child: Padding(
                        padding: EdgeInsets.all(20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Request details',
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
                            CustomTxtField(label: 'Issue Title', hint: 'Enter here',
                                txt: title, enabled: true, lines: 1),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTxtField(label: 'Issue Details',
                                hint: 'Enter here', txt: detail, enabled: true, lines: 3),
                            SizedBox(
                              height: 10.h,
                            ),
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
                                child: CustomTxtField(
                                    label:
                                    'When did you start facing the issue? ',
                                    hint: 'DD MM YYYY',
                                    txt: date,
                                    enabled: false,
                                    lines: 1)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (title.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    'Please Enter Title',
                                    style: TextStyle(color: Colors.white),
                                  )));
                                } else if (detail.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    'Please Enter detail',
                                    style: TextStyle(color: Colors.white),
                                  )));
                                } else if (date.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    'Please Enter Date',
                                    style: TextStyle(color: Colors.white),
                                  )));
                                } else {

                                  await postRequest();
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
                                    'Submit',
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
                    ),
                  ],
                ),
              ),
            )
          : LoadingWidget(context),
    );
  }

  postRequest() async {
    var user = Provider.of<UserProvider>(context, listen: false);
    var id = getRandomString(28);
    var data = {
      'uid': id,
      'createdById': user.user!.uid,
      'title': title.text,
      'description': detail.text,
      'status': 'In Progress',
      'step': '1',
      'date': date.text,
      'responseAdmin':'',
      'closed': false
    };
    user.setIsLoading(true);

    await user.postUserRequest(data).then((value) {
      user.setIsLoading(false);
      showToast('Request submitted successfully');

      Navigator.pop(context);
    }).catchError((e){
      print(e);
      user.setIsLoading(false);
      showToast('Request submission failed, try again');
    });
  }
}
