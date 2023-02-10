import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTxtField extends StatelessWidget {
  CustomTxtField(
      {Key? key,
      this.hint,
      this.label,
      required this.txt,
      this.enabled,
      this.lines})
      : super(key: key);

  String? hint, label;
  TextEditingController txt;
  bool? enabled;
  int? lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            style: GoogleFonts.nunitoSans(
                color: Theme.of(context).primaryColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5.h,
          ),
          lines! < 2
              ? SizedBox(
                  height: 35.h,
                  child: TextField(
                    controller: txt,
                    cursorColor: Colors.black,
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                    maxLines: lines,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: hint,
                      enabled: enabled!,
                      hintStyle: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : TextField(
                  controller: txt,
                  cursorColor: Colors.black,
                  style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                  maxLines: lines,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: hint,
                    enabled: enabled!,
                    hintStyle: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
        ],
      ),
    );
  }
}

class CustomTxtField1 extends StatefulWidget {
  CustomTxtField1(
      {Key? key,
      this.hint,
      this.label,
      required this.txt,
      this.enabled,
      this.lines,
      this.prefixIcon, this.obscure = false})
      : super(key: key);

  String? hint, label;
  TextEditingController txt;
  bool? enabled, obscure;
  IconData? prefixIcon;
  int? lines;

  @override
  State<CustomTxtField1> createState() => _CustomTxtField1State();
}

class _CustomTxtField1State extends State<CustomTxtField1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border:
              Border.all(color: Color.fromRGBO(238, 238, 238, 1), width: 1)),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Row(
        children: [
          Icon(
            widget.prefixIcon!,
            color: Theme.of(context).primaryColor,
            size: 25.sp,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label!,
                  style: GoogleFonts.nunitoSans(
                      color: Theme.of(context).primaryColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  height: 30,
                  child: TextField(
                    controller: widget.txt,
                    cursorColor: Colors.black,
                    style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                    maxLines: widget.lines,
                    obscureText:
                        widget.obscure != null ? widget.obscure! : false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      enabled: widget.enabled!,
                      hintText: widget.hint!,
                      hintStyle: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          widget.label! == 'Password'
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.obscure = !widget.obscure!;
                    });
                  },
                  child: Icon(
                    widget.obscure != null &&  widget.obscure == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Theme.of(context).primaryColor,
                  ))
              : Container()
        ],
      ),
    );
  }
}
