import 'package:barleryroof/Views/BookRoomPage.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_more_text/read_more_text.dart';

class AdminRoomDetailsPage extends StatefulWidget {
  const AdminRoomDetailsPage({Key? key}) : super(key: key);

  @override
  State<AdminRoomDetailsPage> createState() => _AdminRoomDetailsPageState();
}

class _AdminRoomDetailsPageState extends State<AdminRoomDetailsPage> {
  var status=true;
  var status1=true;
  var status2=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        height: MediaQuery.of(context).size.height ,
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
                      IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_outlined,color: Colors.black,size: 30,)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Text(
                              'Room 1',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        
                      )
                    ],
                  ),
                ],
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.87,
              child: SingleChildScrollView(
                  child: Column(
                      children:[
                        Container(

                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(20),
                                width: 326.w,
                                height: 180.h,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(color: Colors.black26,spreadRadius: 1,blurRadius: 10)],
                                    image: DecorationImage(image: AssetImage('assets/images/hotel.png'),fit: BoxFit.fill)
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Empire Flats',
                                          style: GoogleFonts.nunitoSans(
                                              color: Colors.black,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,color: Theme.of(context).primaryColor,size: 20,),
                                            Text(
                                              'Empire Buildings 628',
                                              style: GoogleFonts.nunitoSans(
                                                  color:Colors.grey,
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
                                          '\$125k',
                                          style: GoogleFonts.nunitoSans(
                                              color:Theme.of(context).primaryColor,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'per month',
                                          style: GoogleFonts.nunitoSans(
                                              color:Colors.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
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
                            'Featuring a bar, Grandi by Center Hotels is located in Reykjavík in the Reykjavik Greater region, 2.4 km from Solfar Sun Voyager and 2.6 km from Hallgrímskirkja Church. Among the facilities of this property are a restaurant, a 24-hour',
                            numLines: 4,
                            readMoreText: 'Read more',
                            readLessText: 'Read less',
                            readMoreIconColor: Theme.of(context).primaryColor,
                            style: TextStyle(color: Colors.grey),
                            readMoreTextStyle: TextStyle(color: Theme.of(context).primaryColor),
                          ),
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
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child:ImageIcon(AssetImage('assets/images/Frame (1).png'),color: Theme.of(context).primaryColor,),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Free Wifi',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child:ImageIcon(AssetImage('assets/images/Frame (2).png'),color: Theme.of(context).primaryColor,),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Parking',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child:ImageIcon(AssetImage('assets/images/Frame (3).png'),color: Theme.of(context).primaryColor,),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Laundry',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child:ImageIcon(AssetImage('assets/images/Frame (4).png'),color: Theme.of(context).primaryColor,),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Pool',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w,vertical:20.h),
                          child: Row(
                            children: [
                              Text(
                                'Tenants',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10.r)),
                            padding: EdgeInsets.all(10.h),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                                          image: DecorationImage(
                                              image: AssetImage('assets/images/man.png'),
                                              fit: BoxFit.fill)),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ' Joshua Milian',
                                          style: GoogleFonts.nunitoSans(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,color: Theme.of(context).primaryColor,size: 20.w,),
                                            Text(
                                              ' Empire Buildings 628',
                                              style: GoogleFonts.nunitoSans(
                                                  color: Colors.grey,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      ' \$150k',
                                      style: GoogleFonts.nunitoSans(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      ' In 3 days',
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
                        SizedBox(height: 10.h,),
                        GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10.r)),
                            padding: EdgeInsets.all(10.h),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                                          image: DecorationImage(
                                              image: AssetImage('assets/images/man.png'),
                                              fit: BoxFit.fill)),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ' Joshua Milian',
                                          style: GoogleFonts.nunitoSans(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,color: Theme.of(context).primaryColor,size: 20.w,),
                                            Text(
                                              ' Empire Buildings 628',
                                              style: GoogleFonts.nunitoSans(
                                                  color: Colors.grey,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      ' \$150k',
                                      style: GoogleFonts.nunitoSans(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      ' In 3 days',
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
                        SizedBox(height: 10.h,),
                        GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10.r)),
                            padding: EdgeInsets.all(10.h),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                                          image: DecorationImage(
                                              image: AssetImage('assets/images/man.png'),
                                              fit: BoxFit.fill)),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ' Joshua Milian',
                                          style: GoogleFonts.nunitoSans(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,color: Theme.of(context).primaryColor,size: 20.w,),
                                            Text(
                                              ' Empire Buildings 628',
                                              style: GoogleFonts.nunitoSans(
                                                  color: Colors.grey,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      ' \$150k',
                                      style: GoogleFonts.nunitoSans(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      ' In 3 days',
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
                        SizedBox(height: 10.h,),
                        GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10.r)),
                            padding: EdgeInsets.all(10.h),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                                          image: DecorationImage(
                                              image: AssetImage('assets/images/man.png'),
                                              fit: BoxFit.fill)),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ' Joshua Milian',
                                          style: GoogleFonts.nunitoSans(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,color: Theme.of(context).primaryColor,size: 20.w,),
                                            Text(
                                              ' Empire Buildings 628',
                                              style: GoogleFonts.nunitoSans(
                                                  color: Colors.grey,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      ' \$150k',
                                      style: GoogleFonts.nunitoSans(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      ' In 3 days',
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

                        SizedBox(height: 20,)
                      ]
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
