import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hospitality_92/Model/Celebrate_with_us.dart';
import 'package:hospitality_92/Model/Must_Visit_Destinations.dart';
import 'package:hospitality_92/Model/Popular_In_Pakistan.dart';
import 'package:hospitality_92/Widgets/Video_Player_Card.dart';
import 'package:hospitality_92/Widgets/Celebrate_with_Us_Card.dart';
import 'package:hospitality_92/Widgets/Must_Visit_Destination_Card.dart';
import 'package:hospitality_92/Widgets/Popular_In_Pakistan_Card.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../Utils/constants.dart';

class TourismScreen extends StatefulWidget {
  static const routeName = '/tourism_screen.dart';

  @override
  _TourismScreenState createState() => _TourismScreenState();
}

class _TourismScreenState extends State<TourismScreen> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1599106242383-271adeb2e828?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8aGlsbHN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1541675154750-0444c7d51e8e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGhpbGxzfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1519414442781-fbd745c5b497?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjV8fGhpbGxzfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 95.0.h,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:   EdgeInsets.only(top: 0.0.sp, right: 4.0.sp),
              child: Container(
                color: Colors.white,
                height: 30.0.h,
                  child: Center(child: VideoItem("https://hospitality92.com/uploads/products/1624530723.mp4"))
              ),
            ),
            Container(
              height: 25.0.h,
              width: 100.0.w,
              child: CarouselSlider(
                options: CarouselOptions(autoPlay: true),
                items: imgList.map((item) => Container(child: Image.network(item, fit: BoxFit.cover, width: 100.0.w))).toList(),
              ),
            ),
            Container(
              //color: Colors.lightBlue,
              height: 23.0.h,

              child: Column(
                children: [
                  CategoryTitleContainer(6.0.h, Colors.white, 'Must Visit Destination', 0.0, 20.0.sp, kPrimaryColor),
                  Container(
                    height: 16.0.h,
                    color: Colors.white,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: mustVisitDestinations.length,
                          itemBuilder: (BuildContext context, int index) {
                            return MustVisitDestinationCard(
                              mustVisitDestinations: mustVisitDestinations[index],
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 23.0.h,
              child: Column(
                children: [
                  CategoryTitleContainer(6.0.h, Colors.white, 'Popular In Pakistan', 0.0, 20.0.sp, kPrimaryColor),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 16.0.h,
                          color: Colors.white,
                          child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: popularInPakistan.length,
                              itemBuilder: (BuildContext context, int index) {
                                return PopularInPakistanCard(
                                  popularInPakistan: popularInPakistan[index],
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 23.0.h,
              child: Column(
                children: [
                  CategoryTitleContainer(6.0.h, Colors.white, 'Celebrate With Us', 0.0, 20.0.sp, kPrimaryColor),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 16.0.h,
                          color: Colors.white,
                          child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: celebrateItems.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CelebrateWithUsCard(
                                  celebrateWithUs: celebrateItems[index],
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 5.0.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget CategoryTitleContainer(double height, Color color, String title, double containerMargin, double rowPadding, Color viewAllColor) {
    return Container(
      color: color,
      margin: EdgeInsets.symmetric(horizontal: containerMargin),
      height: height,
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
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 10.0.sp),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0.sp / 4),
              width: 20.0.w,
              child: Center(
                child: Text(
                  'See All',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: viewAllColor, fontWeight: FontWeight.w400, fontSize: 10.0.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogContainer extends StatefulWidget {
  @override
  _BlogContainerState createState() => _BlogContainerState();
}

class _BlogContainerState extends State<BlogContainer> {
  Future<List<dynamic>> getBlogsData() async {
    String url = 'https://hospitality92.com/api/blogsbycategory_and_city/Tourism/1';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return json.decode(response.body)['blogs'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  var bloggerName = snapshot.data![index]['name'];
                  var bloggerQuote = snapshot.data![index]['quote'];
                  var blogDescription = snapshot.data![index]['description'];
                  var blogImage = 'https://hospitality92.com/uploads/products/${snapshot.data![index]['image']}';

                  return InkWell(
                    onTap: () {},
                    child: Container(
                      height: 30.0.h,
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
                              /*'https://images.unsplash.com/photo-1495745966610-2a67f2297e5e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cGhvdG9ncmFwaGVyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',*/
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
                            padding: EdgeInsets.symmetric(vertical: kDefaultPadding.sp / 3, horizontal: kDefaultPadding * 2),
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
                                      /*
                                          'Photographers are going to earn more this year Photographers are going to earn more this year Photographers are going to earn more this year ',
                                          */
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
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 10.0.sp),
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
    );
  }
}
