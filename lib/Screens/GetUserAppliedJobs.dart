import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitality_92/Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class GetUserAppliedJob extends StatefulWidget {
  const GetUserAppliedJob({Key? key}) : super(key: key);

  @override
  _GetUserAppliedJobState createState() => _GetUserAppliedJobState();
}

class _GetUserAppliedJobState extends State<GetUserAppliedJob> {

/*  List<String> allJobsList = [];
  Future<List<dynamic>> getAllJobsData() async {
    String url = 'https://hospitality92.com/api/jobsbycategory/All';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    allJobsList.add(json.decode(response.body)['jobs'].toString()); // here all jobs response added to list

    return json.decode(response.body);
  }*/

  Future<List<dynamic>> getUserAppliedData() async {
    String url = 'https://hospitality92.com/api/getappliedjobs/10';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return json.decode(response.body)['jobs']; // this returns user applied jobs
  }

  @override
  Widget build(BuildContext context) {
    getUserAppliedData();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 8.0.h,
        automaticallyImplyLeading: false,
        title: Text(
          "Applied Jobs",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
            size: 20.0.sp,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              //height: 27.0.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<List<dynamic>>(
                  future: getUserAppliedData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp / 2, vertical: kDefaultPadding.sp / 5),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            var jobID = int.parse(snapshot.data![index]['job_id']) ;
                            var userExperience = snapshot.data![index]['experience'];
                            var userSalary = snapshot.data![index]['salary'];
                            var userCareer = snapshot.data![index]['career'];
                            var userDocument = snapshot.data![index]['document'];
                            var jobStatus = snapshot.data![index]['status'];
                            var job =  snapshot.data![index]['job'];

                            var title = job['title'];


                            print("svsdfvsfvsdfv = " + title);


                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(left: kDefaultPadding.sp / 2, right: kDefaultPadding.sp / 2, bottom: kDefaultPadding.sp / 2),
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
                                                  "Rs. " +userSalary,
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
                                                    userDocument,
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
                                                        jobStatus,
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
            ),
          ],
        ),
      ),
    );
  }
}
