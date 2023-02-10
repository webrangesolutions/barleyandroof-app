import 'package:barleryroof/models/unit_model.dart';
import 'package:barleryroof/providers/announe_provider.dart';
import 'package:barleryroof/providers/unit_provider.dart';
import 'package:barleryroof/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';
import 'PaymentHistoryPage.dart';
import 'RequestsPage.dart';
import 'SettingsPage.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({Key? key}) : super(key: key);

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  List pages=[
    HomePage(),
    PaymentHistoryPage(),
    RequestsPage(),
    SettingsPage(),
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
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/Vector (12).png')),label: 'Home'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/Group 754.png')),label: 'Home'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/Group 768.png')),label: 'Home'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/Vector (13).png')),label: 'Home'),
        ],
      ),
    );
  }
}
