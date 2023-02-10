import 'package:barleryroof/models/announce_model.dart';
import 'package:barleryroof/providers/announe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Views/NotificationsPage.dart';
import '../constant.dart';
import '../providers/unit_provider.dart';
import '../providers/user_provider.dart';

class AdminAnnouncement extends StatelessWidget {
  const AdminAnnouncement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var announce = Provider.of<AnnounceProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '${user.user!.profilePicture}'),
                                      fit: BoxFit.fill)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user.user!.name}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Good Morning!',
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.grey,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => NotificationsPage()));
                          },
                          child: Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.notifications,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
                child: ListView.builder(
                    itemCount: announce.announceList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var sortedAL = announce.announceList;
                      sortedAL.sort((a, b) => int.parse(b.timestamp!)
                          .compareTo(int.parse(a.timestamp!)));
                      var x = sortedAL[index];
                      print(x);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditAnnouncement(
                                        announce: x,
                                      )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          padding: EdgeInsets.all(10.h),
                          margin: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${x.title}',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '${x.description}',
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${x.type}',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddAnnouncement()));
        },
      ),
    );
  }
}

class AddAnnouncement extends StatefulWidget {
  const AddAnnouncement({Key? key}) : super(key: key);

  @override
  State<AddAnnouncement> createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {
  TextEditingController title = new TextEditingController();
  TextEditingController subTitle = new TextEditingController();

  var type = 'Global';
  var project = '';

  @override
  void initState() {
    super.initState();

    if(mounted){
      var units = Provider.of<UnitProvider>(context, listen: false);
      setState(() {
        project = units.unitList.length > 0 ? units.unitList.first.title! : '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var units = Provider.of<UnitProvider>(context);

    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Announcement',
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
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
                              'Announcement Title',
                              style: GoogleFonts.nunitoSans(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 20,
                              child: TextFormField(
                                controller: title,
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
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
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
                              'Details',
                              style: GoogleFonts.nunitoSans(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 20,
                              child: TextFormField(
                                controller: subTitle,
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
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
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
                              'Type',
                              style: GoogleFonts.nunitoSans(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: DropdownButton(
                                value: type,
                                onChanged: (val) {
                                  setState(() {
                                    type = val!;
                                  });
                                },
                                items: ['Global', 'Project']
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
                  type == 'Project' && project.isNotEmpty ?
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
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
                              'Project',
                              style: GoogleFonts.nunitoSans(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: DropdownButton(
                                value: project,
                                onChanged: (val) {
                                  setState(() {
                                    project = val!;
                                  });
                                },
                                items: units.unitList
                                    .map((v) => DropdownMenuItem(
                                     value: v.title, child: Text('${v.title}')))
                                    .toList(),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ) : Container(),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (title.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please enter announcement title')));
                      } else if (subTitle.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Please enter announcement description')));
                      } else {
                        await postAnnouncement();
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
                          user.isLoading == false ? 'Submit' : 'Loading...',
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
            )
          ],
        ),
      ),
    ));
  }

  postAnnouncement() async {
    var user = Provider.of<UserProvider>(context, listen: false);
    var announce = Provider.of<AnnounceProvider>(context, listen: false);

    var id = getRandomString(28);

    var data = {
      'uid': id,
      'title': title.text,
      'description': subTitle.text,
      'timestamp': DateTime.now().microsecondsSinceEpoch.toString(),
      'project': type == 'Project' ? project : '',
      'type': type
    };

    user.setIsLoading(true);

    await announce.postAnnouncement(data).then((value) {
      user.setIsLoading(false);
      print(value);
      if (value['success'] == true) {
        showToast('New Announcement added !');

        Navigator.pop(context);
      } else {
        showToast(errorTxt);
      }
    }).catchError((e) {
      user.setIsLoading(false);
    });
  }
}

class EditAnnouncement extends StatefulWidget {
  const EditAnnouncement({Key? key, this.announce}) : super(key: key);

  final AnnounceModel? announce;

  @override
  State<EditAnnouncement> createState() => _EditAnnouncementState();
}

class _EditAnnouncementState extends State<EditAnnouncement> {
  TextEditingController title = new TextEditingController();
  TextEditingController subTitle = new TextEditingController();

  var type = '';
  var project = '';
  bool delete = false;

  @override
  void initState() {
    var units = Provider.of<UnitProvider>(context, listen: false);
    if (mounted == true) {
      setState(() {
        title.text = widget.announce!.title!;
        subTitle.text = widget.announce!.description!;
        type = widget.announce!.type!;

        setState(() {
          project = units.unitList.length > 0 ? units.unitList.first.title! : '';
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var announce = Provider.of<AnnounceProvider>(context);
    var units = Provider.of<UnitProvider>(context, listen: false);

    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Announcement',
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
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
                              'Announcement Title',
                              style: GoogleFonts.nunitoSans(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 20,
                              child: TextFormField(
                                controller: title,
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
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
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
                              'Details',
                              style: GoogleFonts.nunitoSans(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 20,
                              child: TextFormField(
                                controller: subTitle,
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
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
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
                              'Type',
                              style: GoogleFonts.nunitoSans(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: DropdownButton(
                                value: type,
                                onChanged: (val) {
                                  setState(() {
                                    type = val!;
                                  });
                                },
                                items: ['Global', 'Project']
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
                  type == 'Project' && project.isNotEmpty ?
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
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
                              'Project',
                              style: GoogleFonts.nunitoSans(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 20,
                              child: DropdownButton(
                                value: project,
                                onChanged: (val) {
                                  setState(() {
                                    project = val!;
                                  });
                                },
                                items: units.unitList
                                    .map((v) => DropdownMenuItem(
                                    value: v.title, child: Text('${v.title}')))
                                    .toList(),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ) : Container(),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                        await updateAnnouncement();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50.h,
                      child: Center(
                        child: Text(
                          user.isLoading == false ? 'Submit' : 'Loading...',
                          style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
setState(() {
  delete = true;
});
                      await fireStore
                          .collection('Announcement')
                          .doc(widget.announce!.uid)
                          .delete()
                          .then((value) async {
                            setState(() {
                              delete = false;
                            });
                        showToast('Announcement delete !');
                        announce.fetchAllAnnouncements();
                        Navigator.pop(context);
                      }).catchError((e){setState(() {
                        delete = false;
                      });});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50.h,
                      child: Center(
                        child: Text(
                          delete == false ? 'Delete' : 'Loading...',
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
            )
          ],
        ),
      ),
    ));
  }

  updateAnnouncement() async {
    var user = Provider.of<UserProvider>(context, listen: false);
    var announce = Provider.of<AnnounceProvider>(context, listen: false);

    var data = {
      'title': title.text,
      'description': subTitle.text,
      'project': project,
      'type': type
    };

    user.setIsLoading(true);

    await announce.updateAnnounce(widget.announce!.uid, data).then((value) {
      user.setIsLoading(false);
      if (value['success'] == true) {
        showToast('Announcement updated !');

        Navigator.pop(context);
      } else {
        showToast(errorTxt);
      }
    }).catchError((e) {
      user.setIsLoading(false);
    });
  }
}
