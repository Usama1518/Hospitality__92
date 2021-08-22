import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Utils/constants.dart';
import 'package:http/http.dart' as http;

class BlogOverviewCard extends StatefulWidget {
  @override
  _BlogOverviewCardState createState() => _BlogOverviewCardState();
}

class _BlogOverviewCardState extends State<BlogOverviewCard> {
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
      height: 28.0.h,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding.sp / 2, horizontal: kDefaultPadding.sp),
      child: FutureBuilder<List<dynamic>>(
        future: getBlogsData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                controller: new ScrollController(keepScrollOffset: false),
                scrollDirection: Axis.vertical,
                itemCount: 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  var bloggerName = snapshot.data![index]['name'];
                  var bloggerQuote = snapshot.data![index]['quote'];
                  var blogDescription = snapshot.data![index]['description'];
                  var blogImage = 'https://hospitality92.com/uploads/products/${snapshot.data![index]['image']}';

                  return InkWell(
                      onTap: () {},
                      child: Container(
                        child: Stack(children: [
                          Container(
                            height: 25.0.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                blogImage,
                                /*'https://images.unsplash.com/photo-1495745966610-2a67f2297e5e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cGhvdG9ncmFwaGVyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',*/
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Container(
                            height: 25.0.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black12,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: kDefaultPadding.sp / 3,
                                  horizontal: kDefaultPadding),
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
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0.sp),
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
                                          'Author:',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 10.0.sp),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          bloggerName/*'Zulqarnain Haider '*/,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10.0.sp),
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
          return CircularProgressIndicator();
        },
      ),

      /*
      Stack(children: [
          Container(
            height: 25.0.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderRadius.sp),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kBorderRadius.sp),
              child: Image.network(
                'https://images.unsplash.com/photo-1495745966610-2a67f2297e5e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cGhvdG9ncmFwaGVyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Container(
            height: 25.0.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderRadius.sp),
              color: Colors.black12,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding.sp / 3,
                  horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 12.0.h,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Photographers are going to earn more this year Photographers are going to earn more this year Photographers are going to earn more this year ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0.sp),
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
                          'Author:',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 10.0.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Zulqarnain Haider ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0.sp),
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
        ]),*/
    );
  }
}
