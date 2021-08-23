
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitality_92/Screens/Hotel.dart';
import 'package:hospitality_92/Screens/More.dart';
import 'package:hospitality_92/Screens/Others.dart';
import 'package:hospitality_92/Screens/Tourism_Screen.dart';
import 'package:hospitality_92/Screens/Videos.dart';
import 'package:sizer/sizer.dart';
import 'HomeBox.dart';
import '../Utils/constants.dart';
import 'Resturants_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  late PageController _pageController;

  void _changePage(int pageNum) {
    setState(() {
      _selectedPage = pageNum;
        _pageController.animateToPage(
        pageNum,
        duration: Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void initState() {
    super.initState();
     _pageController = PageController();
  }
  @override
  void dispose() {
    super.dispose();
      _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Color(0xff090577),
              height: 12.0.h,
              child:
              Padding(
                padding: EdgeInsets.only(top: kDefaultPadding.sp*2-10.0.sp),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TabButton(
                        text: "Carriera",
                        pageNumber: 0,
                        selectedPage: _selectedPage,
                        onPressed: () {
                          _changePage(0);
                        },
                      ),
                      TabButton(
                        text: "Restaurents",
                        pageNumber: 1,
                        selectedPage: _selectedPage,
                        onPressed: () {
                          _changePage(1);
                        },
                      ),
                      TabButton(
                        text: "Videos",
                        pageNumber: 2,
                        selectedPage: _selectedPage,
                        onPressed: () {
                          _changePage(2);
                        },
                      ),
                      TabButton(
                        text: "Others",
                        pageNumber: 3,
                        selectedPage: _selectedPage,
                        onPressed: () {
                          _changePage(3);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                onPageChanged: (int page) {
                  setState(() {
                    _selectedPage = page;
                  });
                },
                controller: _pageController,
                children: [
                  HomeBox(),
                  OthersItems(),

                  RestaurantsScreen(),
                  VideosScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }



}


class TabButton extends StatelessWidget {
  final String text;
  final int selectedPage;
  final int pageNumber;
  final VoidCallback onPressed;
  TabButton({required this.text, required this.selectedPage, required this.pageNumber, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(

        duration: Duration(
            milliseconds: 1000
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        margin: EdgeInsets.only(left: kDefaultPadding.sp/2, top: kDefaultPadding.sp/4),
        width: 26.0.w,
        height: 4.0.h,
        decoration: BoxDecoration(
          color: selectedPage == pageNumber ? kWhiteColor : kWhiteColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(kBorderRadius.sp),
        ),

        child: Center(
          child: Text(
            text ?? "Tab Button",
            style: TextStyle(
              fontSize: 10.0.sp,
              color: selectedPage == pageNumber ? kPrimaryColor : Colors.white30,
            ),
          ),
        ),
      ),
    );
  }
}
