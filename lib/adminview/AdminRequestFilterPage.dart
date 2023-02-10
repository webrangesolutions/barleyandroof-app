import 'package:barleryroof/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestFilterPage extends StatefulWidget {
  const RequestFilterPage({Key? key, this.title, this.page}) : super(key: key);

  final String? title;
  final int? page;

  @override
  State<RequestFilterPage> createState() => _RequestFilterPageState();
}

var progressStatus = [
  {'title': 'Request Submitted', 'selected': false},
  {'title': 'In Progress', 'selected': false},
  {'title': 'Closed', 'selected': false},
];

var sortBy = [
  {'title': 'Ascending', 'selected': false},
  {'title': 'Descending', 'selected': false},
];

var days = [
  {'title': '3', 'selected': false},
  {'title': '7', 'selected': false},
  {'title': '10', 'selected': false},
  {'title': '15', 'selected': false},
];

var progressCase = [
  {'title': '1', 'selected': false},
  {'title': '2', 'selected': false},
  {'title': '3', 'selected': false},
  {'title': '4', 'selected': false},
  {'title': '5', 'selected': false},
];

class _RequestFilterPageState extends State<RequestFilterPage> {
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
                              if (widget.page == 1) {
                                filters.addAll({
                                  'progressStatus': progressStatus
                                              .where((ps) =>
                                                  ps['selected'] == true)
                                              .length >
                                          0
                                      ? progressStatus
                                          .where((ps) => ps['selected'] == true)
                                          .first['title']
                                      : ''
                                });
                              }
                              if (widget.page == 0 || widget.page == 2) {
                                filters.addAll({
                                  'order': sortBy
                                              .where((ps) =>
                                                  ps['selected'] == true)
                                              .length >
                                          0
                                      ? sortBy
                                          .where((ps) => ps['selected'] == true)
                                          .first['title']
                                      : '',
                                  'days': days
                                              .where((ps) =>
                                                  ps['selected'] == true)
                                              .length >
                                          0
                                      ? days
                                          .where((ps) => ps['selected'] == true)
                                          .first['title']
                                      : '',
                                });
                              }

                              Navigator.pop(context, filters);
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
                                widget.title!,
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
              SizedBox(
                height: 20.h,
              ),
              widget.page == 1
                  ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Progress Status'),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                height: 40,
                                child: ListView.builder(
                                    itemCount: progressStatus.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (progressStatus[index]['selected'] ==
                                              false) {
                                            setState(() {
                                              progressStatus[index]['selected'] =
                                              true;
                                            });

                                            progressStatus
                                                .where((ps) =>
                                            (ps['title'] !=
                                                progressStatus[index]
                                                ['title']) &&
                                                (ps['selected'] == true))
                                                .first['selected'] = false;
                                          } else {
                                            setState(() {
                                              progressStatus[index]['selected'] =
                                              false;
                                            });
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10.w),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 4.h),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(18.r),
                                              color: progressStatus[index]
                                              ['selected'] ==
                                                  false
                                                  ? Colors.grey.shade100
                                                  : Colors.grey.shade300),
                                          child: Center(
                                            child: Text(
                                                '${progressStatus[index]['title']}'),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Progress Case'),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                height: 40,
                                child: ListView.builder(
                                    itemCount: progressCase.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (progressCase[index]['selected'] ==
                                              false) {
                                            setState(() {
                                              progressCase[index]['selected'] =
                                                  true;
                                            });

                                            progressCase
                                                .where((ps) =>
                                                    (ps['title'] !=
                                                        progressCase[index]
                                                            ['title']) &&
                                                    (ps['selected'] == true))
                                                .first['selected'] = false;
                                          } else {
                                            setState(() {
                                              progressCase[index]['selected'] =
                                                  false;
                                            });
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10.w),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 4.h),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18.r),
                                              color: progressCase[index]
                                                          ['selected'] ==
                                                      false
                                                  ? Colors.grey.shade100
                                                  : Colors.grey.shade300),
                                          child: Center(
                                            child: Text(
                                                'Step ${progressCase[index]['title']}'),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  : Container(),
              widget.page == 0 || widget.page == 2
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sort Order (Price)'),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                      itemCount: sortBy.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (sortBy[index]['selected'] ==
                                                false) {
                                              setState(() {
                                                sortBy[index]['selected'] =
                                                    true;
                                              });

                                              if(                                              sortBy
                                                  .where((ps) =>
                                              (ps['title'] !=
                                                  sortBy[index]
                                                  ['title']) &&
                                                  (ps['selected'] == true)).length > 0){}
                                              sortBy
                                                  .where((ps) =>
                                                      (ps['title'] !=
                                                          sortBy[index]
                                                              ['title']) &&
                                                      (ps['selected'] == true))
                                                  .first['selected'] = false;
                                            } else {
                                              setState(() {
                                                sortBy[index]['selected'] =
                                                    false;
                                              });
                                            }
                                          },
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(right: 10.w),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 4.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18.r),
                                                color: sortBy[index]
                                                            ['selected'] ==
                                                        false
                                                    ? Colors.grey.shade100
                                                    : Colors.grey.shade300),
                                            child: Center(
                                              child: Text(
                                                  '${sortBy[index]['title']}'),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.page == 0 ? 'Upcoming Payment Days' : 'Tenant Moving Days'),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                      itemCount: days.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (days[index]['selected'] ==
                                                false) {
                                              setState(() {
                                                days[index]['selected'] = true;
                                              });

                                              if (days
                                                      .where((ps) =>
                                                          (ps['title'] !=
                                                              days[index]
                                                                  ['title']) &&
                                                          (ps['selected'] ==
                                                              true))
                                                      .length >
                                                  0) {
                                                days
                                                    .where((ps) =>
                                                        (ps['title'] !=
                                                            days[index]
                                                                ['title']) &&
                                                        (ps['selected'] ==
                                                            true))
                                                    .first['selected'] = false;
                                              }
                                            } else {
                                              setState(() {
                                                days[index]['selected'] = false;
                                              });
                                            }
                                          },
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(right: 10.w),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 4.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18.r),
                                                color: days[index]
                                                            ['selected'] ==
                                                        false
                                                    ? Colors.grey.shade100
                                                    : Colors.grey.shade300),
                                            child: Center(
                                              child: Text(
                                                  '${days[index]['title']}'),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
