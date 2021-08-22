import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospitality_92/Screens/Hotel.dart';
import 'package:hospitality_92/Screens/More.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'Home_Screen.dart';
import 'Jobs.dart';
import '../Widgets/FABBottomAppBarItem.dart';
import 'Main_Tourism_Screen.dart';
import 'Tourism_Screen.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedItemIndex = 0;

  void _selectedTab(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  final List<Widget> _children = [HomeScreen(), MainTourismScreen(), Hotel(), MoreSettings()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_selectedItemIndex == 0) return true;
          setState(() {
            _selectedItemIndex = 0;
          });
          return false;
        },
        child: Scaffold(
          body: _children[_selectedItemIndex],
          bottomNavigationBar: FABBottomAppBar(
            //  onTabSelected: _selectedTab,
            items: [
              FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
              FABBottomAppBarItem(iconData: Icons.tour, text: 'Tourism'),
              FABBottomAppBarItem(iconData: Icons.king_bed, text: 'Hotel'),
              FABBottomAppBarItem(iconData: Icons.horizontal_split_sharp, text: 'More'),
            ],

            backgroundColor: Colors.white,
            centerItemText: 'Jobs',
            notchedShape: CircularNotchedRectangle(),
            color: Colors.black54,
            selectedColor: Color(0xff0e8ef7),
            onTabSelected: _selectedTab,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 40.0.sp,
            width: 40.0.sp,
            child: new FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LatestJobs()));
              },
              child: FaIcon(
                FontAwesomeIcons.briefcase,
                color: Colors.white,
                size: 16.0.sp,
              ),
            ),
          ),
        ));
  }


}
