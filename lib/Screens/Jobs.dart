import 'dart:convert';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:hospitality_92/Model/JobsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ApplyForJob.dart';

class LatestJobs extends StatefulWidget {
  @override
  _LatestJobsState createState() => _LatestJobsState();
}

class _LatestJobsState extends State<LatestJobs> {
  late JobItem jobItem;
  var count = 0;


  Future<List<dynamic>> getFilteredJObs({
    required String city,
    required String searchCategories,
  }) async {
    const url = 'https://hospitality92.com/api/searchjobs';
    final response = await http.post(
      Uri.parse(url),
      body: {'city': city, 'search_categories': searchCategories},
    );
    var counter = json.decode(response.body)['jobcount'];
    count = counter;
    print("total JOb" + count.toString());
    return json.decode(response.body)['jobs'];
  }

  String cityDropDownValue = "";
  String categoryDpValue = "";
  String cityKeyWord = '';
  String categoryKeyword = '';

  List<String> citiesList = [];
  List<String> citiesNameList = [];

  Future getCityData() async {
    var response = await http.get(Uri.https('hospitality92.com', 'api/getcities'));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["cities"];
    if (citiesList.length != 0) citiesList.clear();
    for (var i = 0; i < data.length; i++) {
      citiesNameList.add(data[i]["name"]);
      citiesList.add(data[i]["id"].toString() + " " + data[i]["name"]);
    }
    print("Cities Response" + citiesList.toString());
  }

  void getDropDownItem() {

    setState(() {
      cityDropDownValue = cityDropDownValue;
      categoryDpValue = categoryDpValue;
      print("Here is value" + categoryDpValue);
      jobData(cityDropDownValue, categoryDpValue);
    });

  }

  @override
  void initState() {
    getCityData();
    getFilteredJObs(city: '', searchCategories: '');
  }

  @override
  Widget build(BuildContext context) {
    getCityData();
    //getFilteredJObs(city: '', searchCategories: '');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Jobs",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.all(Radius.circular(28)),
                        ),
                        child: DropDownField(
                          //controller: categorySelected,
                          hintText: "Select Category",
                          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
                          enabled: true,
                          items: categoryList,
                          onValueChanged: (value) {
                            setState(() {
                              categoryDpValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.all(Radius.circular(28)),
                        ),
                        child: DropDownField(
                          // controller: citySelected,
                          hintText: "Select City",
                          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
                          enabled: true,
                          items: citiesList,
                          onValueChanged: (value) {
                            setState(() {
                              cityDropDownValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 12.0.sp,
                  top: 8.0.sp,
                  right: 8.0.sp
                ),
                child: Container(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: getDropDownItem,
                    child: Text(
                      "Search Job",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  /*Padding(
                    padding: EdgeInsets.only(left: 12.0.sp, top: 8.0.sp, right: 8.0.sp, bottom: 8.0.sp),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "$count Jobs Found",
                          style: TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.bold),
                        )),
                  ),*/
                  Container(
                    height: 70.h,
                    child: jobData(cityDropDownValue, categoryDpValue),
                  ),
                ],

              ),
              /*RefreshIndicator(
                onRefresh: _pullRefresh,
                child:
              )*/
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    cityDropDownValue = "";
    categoryDpValue = "";
    setState(() {
      jobData(cityDropDownValue, categoryDpValue);
    });
  }

  Widget jobData(String cityID, String catName) {
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: getFilteredJObs(city: cityID, searchCategories: catName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12.0.sp, top: 8.0.sp, right: 8.0.sp, bottom: 8.0.sp),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "$count Jobs Found",
                          style: TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.bold),
                        )),
                  ),
                   ListView.builder(
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
                      var getCityName = "";

                      for (int i = 0; i < citiesNameList.length; i++) {
                        if (i == jobCityID) {
                          var cityName = citiesNameList.elementAt(i - 1);
                          getCityName = cityName;
                          print(getCityName);
                          break;
                        }
                      }
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          child: Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        title,
                                        style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          company + '\n' + getCityName,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 11.sp),
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      width: 60.w,
                                      color: Color(0xC000000),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text("Rs. " + min_salary + " - " + "Rs." + max_salary + " a month", style: TextStyle(fontSize: 11.sp), textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          type,
                                          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              jobItem = JobItem.fromDocument(snapshot, index);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ApplyForJob(jobItem),
                                                  ));
                                            },
                                            child: Text(
                                              "Apply Now",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],

              ),


            );
          }
          return Center(
            child: Container(
              padding: EdgeInsets.only(top: 32.0.sp),
              child: Column(
                children: [
                  Center(
                      child: Text(
                    "Loading Data Found...",
                    style: TextStyle(fontSize: 12.0.sp),
                  )),
                  /*Center(
                      child: Text(
                    "SwipeUp If Not Found!!",
                    style: TextStyle(fontSize: 8.0.sp),
                  )),*/
                  Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final categorySelected = TextEditingController();
final citySelected = TextEditingController();
List<String> categoryList = ["Accountace", "Banking", "Design & Art", "Development", "IT Engineer"];
