import 'package:flutter/material.dart';
import 'package:hospitality_92/Model/blogsModel.dart';
import 'package:sizer/sizer.dart';
import '../Utils/constants.dart';
import 'package:intl/intl.dart';

class BlogDetailScreen extends StatelessWidget {
  final BlogsItem _blogsItem;

  BlogDetailScreen(this._blogsItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blogs Detail",
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Container(
        height: 100.0.h,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              height: 60.0.h,
              color: Colors.white,
              child: Image.network(
                'https://hospitality92.com/uploads/products/${_blogsItem.bloggerImage}',
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
            Container(
              height: 100.0.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 60.0.h,
                      color: Colors.transparent,
                    ),
                    Container(
                      height: 100.0.h,
                      // margin: EdgeInsets.all(kDefaultPadding.sp/3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                //height: 15.0.h,
                                //color: Colors.yellow,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 15.sp, bottom: 15.sp),
                                  child: Center(
                                    child: Text(
                                      '" ${_blogsItem.bloggerQuote} "',
                                      textAlign: TextAlign.center,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: kBlackColor,
                                        fontSize: 16.0.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 10.0.h,
                                // color: Colors.greenAccent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AuthorDate('Blog By:', _blogsItem.bloggerName),
                                    AuthorDate('Published Date:', '2021-06-18' /*DateFormat.yMMMEd().format(_blogsItem.blogCreated_at)*/),
                                  ],
                                ),
                              ),
                              Container(
                                // color: Colors.blue,
                                height: 55.0.h,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.all(kDefaultPadding.sp / 2),
                                    child: Text(
                                      _blogsItem.bloggDescription,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: kBlackColor,
                                        fontSize: 12.0.sp,
                                        //fontWeight: FontWeight,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget AuthorDate(String name, String info) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp / 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 35.0.w,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kGrayColor,
                fontSize: 12.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            //color: Colors.red,
            width: 44.0.w,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                info,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
