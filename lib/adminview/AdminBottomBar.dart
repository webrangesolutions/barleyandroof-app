import 'package:barleryroof/AdminView/AdminHomePage.dart';
import 'package:barleryroof/adminview/AdminAnnouncement.dart';
import 'package:barleryroof/constant.dart';
import 'package:barleryroof/providers/announe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/unit_provider.dart';
import '../providers/user_provider.dart';
import 'AdminRequestsPage.dart';
import 'AdminTenantsPage.dart';
import 'AdminUnitsPage.dart';


class AdminBottomBarPage extends StatefulWidget {
  const AdminBottomBarPage({Key? key}) : super(key: key);

  @override
  State<AdminBottomBarPage> createState() => _AdminBottomBarPageState();
}

class _AdminBottomBarPageState extends State<AdminBottomBarPage> {
  List pages=[
    AdminHomePage(),
    AdminRequestsPage(),
    AdminTenantsPage(),
    AdminAnnouncement(),
    AdminUnitsPage(),
  ];
  var selectedIndex=0;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var user = Provider.of<UserProvider>(context,listen: false);
    var unit = Provider.of<UnitProvider>(context, listen: false);
    var announce = Provider.of<AnnounceProvider>(context, listen: false);

    await user.fetchAllRequests();
    await user.fetchAllUser();
    await unit.fetchAllUnits();
    await unit.fetchAllBookings();
    await unit.fetchAllPayments();
    await announce.fetchAllAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            selectedIndex=index;
          });
        },
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/Group 754.png')),label: 'Home'),
          BottomNavigationBarItem(icon:  Icon(Icons.comment_bank,size: 25.h,),label: 'Home'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/Group 768.png')),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.leak_add_sharp,size: 25.h,),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bedroom_child,size: 25.h,),label: 'Home'),
        ],
      ),
    );
  }
}
