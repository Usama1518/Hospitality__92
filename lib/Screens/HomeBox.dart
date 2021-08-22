import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitality_92/Model/JobsModel.dart';
import 'package:hospitality_92/Model/blogsModel.dart';
import 'package:hospitality_92/Screens/AllBlogs.dart';
import 'package:hospitality_92/Screens/Blog_Detail_Screen.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'Jobs.dart';
import 'JobsDetail.dart';
import '../Utils/constants.dart';
import 'dart:convert';

class HomeBox extends StatefulWidget {
  @override
  _HomeBoxState createState() => _HomeBoxState();
}

class _HomeBoxState extends State<HomeBox> {
  late JobItem jobItem;
  late BlogsItem _blogsItem;

  int currentPos = 0;

  Future<List<dynamic>> getHomeSliderData() async {
    String url = 'https://hospitality92.com/api/gethomeslider';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return json.decode(response.body)['homeslider'];
  }

  Future<List<dynamic>> getJobsData() async {
    String url = 'https://hospitality92.com/api/jobsbycategory/All';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return json.decode(response.body)['jobs'];
  }

  Future<List<dynamic>> getBlogsData() async {
    String url = 'https://hospitality92.com/api/blogsbycategory_and_city/Tourism/1';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return json.decode(response.body)['blogs'];
  }

  List<String> citiesList = [];

  Future getCityData() async {
    var response = await http.get(Uri.https('hospitality92.com', 'api/getcities'));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["cities"];
    if (citiesList.length != 0) citiesList.clear();
    for (var i = 0; i < data.length; i++) {
      citiesList.add(data[i]["name"]);
    }
    print(citiesList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.0.h,
        color: Colors.black.withOpacity(0.1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 33.0.h,
                width: 100.0.w,
                child: FutureBuilder<List<dynamic>>(
                  future: getHomeSliderData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          child: Column(
                            children: [
                              /*Stack()*/
                              CarouselSlider.builder(
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, itemIndex, realIndex) {
                                    var sliderImages = snapshot.data![itemIndex]['image'];

                                    return Container(
                                        decoration: BoxDecoration(
                                      color: Colors.black12,
                                      image: DecorationImage(
                                        image: NetworkImage('https://hospitality92.com/public/home_slider/image/$sliderImages'),
                                        fit: BoxFit.cover,
                                      ),
                                    ));
                                  },
                                  options: CarouselOptions(
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        currentPos = index;
                                      });
                                    },
                                    autoPlay: true,
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: snapshot.data!.map((url) {
                                  int index = snapshot.data!.indexOf(url);
                                  return Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPos == index ? kPrimaryColor : Color.fromRGBO(0, 0, 0, 0.4),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              categoryTitleContainer(Colors.transparent, 'Latest Jobs', 10.0.sp, 0.0.sp, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LatestJobs(),
                    ));
              }),
              Container(
                color: Colors.transparent,
                height: 27.0.h,
                child: FutureBuilder<List<dynamic>>(
                  future: getJobsData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp / 2, vertical: kDefaultPadding.sp / 5),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            var title = snapshot.data![index]['title'];
                            var company = snapshot.data![index]['company_name'];
                            var type = snapshot.data![index]['type'];
                            var min_salary = snapshot.data![index]['min_salary'];
                            var max_salary = snapshot.data![index]['max_salary'];
                            var jobCityID = int.parse(snapshot.data![index]['city_id']);

                            return GestureDetector(
                              onTap: () {
                                jobItem = JobItem.fromDocument(snapshot, index);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobsDetail(jobItem),
                                    ));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: kDefaultPadding.sp / 2,
                                  right: kDefaultPadding.sp / 2,
                                  bottom: kDefaultPadding.sp / 2,
                                ),
                                child: Material(
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(kBorderRadius.sp / 2),
                                  child: Container(
                                    height: 11.0.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(kBorderRadius.sp / 2),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: kBorderRadius.sp / 2),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 4.0.h,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  /*'Senior Developer'*/
                                                  title,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(color: Colors.black87, fontSize: 12.0.sp, fontWeight: FontWeight.w800),
                                                ),
                                              )),
                                          Container(
                                            height: 3.0.h,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.monetization_on_outlined,
                                                  color: Colors.grey,
                                                  size: 12.0.sp,
                                                ),
                                                SizedBox(
                                                  width: kDefaultPadding.sp / 2,
                                                ),
                                                Text(
                                                  "Rs. " + min_salary + " -" + max_salary,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(color: Colors.grey, fontSize: 10.0.sp, fontWeight: FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                              height: 3.0.h,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.home_outlined,
                                                    color: Colors.grey,
                                                    size: 12.0.sp,
                                                  ),
                                                  SizedBox(
                                                    width: kDefaultPadding.sp / 2,
                                                  ),
                                                  Text(
                                                    /*'Islamabad, Pakistan'*/
                                                    company,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(color: Colors.grey, fontSize: 10.0.sp, fontFamily: 'Mulish', fontWeight: FontWeight.w600),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 18.0.w,
                                                    height: 3.0.h,
                                                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(kBorderRadius.sp / 2)),
                                                    child: Center(
                                                      child: Text(
                                                        /*'Full-time'*/
                                                        type,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(color: Colors.white, fontSize: 8.0.sp, fontFamily: 'Mulish', fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              categoryTitleContainer(Colors.white, 'Popular Blog', 0.0.sp, 15.0.sp, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllBlogsScreen(),
                    ));
              }),
              Container(
                height: 30.0.h,
                color: Colors.white,
                child: FutureBuilder<List<dynamic>>(
                  future: getBlogsData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          controller: new ScrollController(keepScrollOffset: false),
                          scrollDirection: Axis.vertical,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            var bloggerName = snapshot.data![index]['name'];
                            var bloggerQuote = snapshot.data![index]['quote'];
                            var blogImage = 'https://hospitality92.com/uploads/products/${snapshot.data![index]['image']}';

                            return InkWell(
                              onTap: () {
                                _blogsItem = BlogsItem.fromDocument(snapshot, index);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlogDetailScreen(_blogsItem),
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: kDefaultPadding.sp / 3, horizontal: kDefaultPadding.sp),
                                child: Stack(children: [
                                  Container(
                                    height: 28.0.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(kBorderRadius.sp),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(kBorderRadius.sp),
                                      child: Image.network(
                                        blogImage,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 28.0.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(kBorderRadius.sp),
                                      color: Colors.black38,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: kDefaultPadding.sp / 2, horizontal: kDefaultPadding * 2),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 12.0.h,
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                bloggerQuote,
                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.0.sp),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 4.0.h,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Blog by:',
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10.0.sp),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  bloggerName /*'Zulqarnain Haider '*/,
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10.0.sp),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            );
                          });
                    }
                    return Align(alignment: Alignment.topCenter, child: CircularProgressIndicator());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryTitleContainer(Color color, String title, double containerMargin, double rowPadding, VoidCallback onPressed) {
    return Container(
      color: color,
      margin: EdgeInsets.symmetric(horizontal: containerMargin),
      height: 7.0.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: rowPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13.0.sp),
            ),
            InkWell(
              onTap: onPressed,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0.sp / 4),
                width: 20.0.w,
                child: Center(
                  child: Text(
                    'See All',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, fontSize: 9.0.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
