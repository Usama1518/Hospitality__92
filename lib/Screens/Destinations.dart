import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class DestinationsScreen extends StatefulWidget {
  const DestinationsScreen({Key? key}) : super(key: key);

  @override
  _DestinationsScreenState createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen> {
  List<String> citiesList = [];

   Future getCityData() async {
    var response = await http.get(Uri.https('hospitality92.com', 'api/getcities'));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["cities"];
    if (citiesList.length != 0) citiesList.clear();
    for (var i = 0; i < data.length; i++) {
      print(i);
      citiesList.add(data[i]["name"]);
    }
    print(citiesList);
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(40),
            child: Container(
                //padding: EdgeInsets.all(8.0.sp),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.white),
                height: 6.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    destinationType('Historical', FontAwesomeIcons.monument, Colors.red),
                    destinationType('Cultural', FontAwesomeIcons.peopleArrows, Colors.green),
                    destinationType('Religious', FontAwesomeIcons.mosque, Colors.blue),
                    destinationType('Recreational', FontAwesomeIcons.umbrellaBeach, Colors.orange),
                    destinationType('Others', FontAwesomeIcons.map, Colors.blue),
                  ],
                )),
          ),
        ),
          Padding(
            padding:  EdgeInsets.only(left: 8.0.sp, right: 8.0.sp),
            child: Material(
              elevation: 4.0,
              child: Container(
                height: 65.h,
                color: Color(0x12000000),
                child:Column(
                   children: [
                     Padding(
                       padding: EdgeInsets.fromLTRB(8.0.sp, 12.0.sp, 8.0.sp, 4.0.sp),
                       child: Container(width: double.infinity,child: Text("Select Destinations",textAlign: TextAlign.start ,style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),)),
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         destinations('attock', FontAwesomeIcons.mosque, Colors.greenAccent),
                         destinations('bahawalnagar', FontAwesomeIcons.placeOfWorship, Colors.greenAccent),
                         destinations('bahawalpur', FontAwesomeIcons.ankh, Colors.greenAccent),
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         destinations('bhakkar', FontAwesomeIcons.khanda, Colors.orangeAccent),
                         destinations('chakwal', FontAwesomeIcons.synagogue, Colors.orangeAccent),
                         destinations('chiniot', FontAwesomeIcons.dove, Colors.orangeAccent),

                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         destinations('bhakkar', FontAwesomeIcons.mosque, Colors.pinkAccent),
                         destinations('chakwal', FontAwesomeIcons.synagogue, Colors.pinkAccent),
                         destinations('chiniot', FontAwesomeIcons.placeOfWorship, Colors.pinkAccent),

                       ],
                     ),
                   ],
                ),
                //color: Colors.red,


              ),
            ),
          ),
/*
        Container(
          margin: const EdgeInsets.all(4.0),
          child: FutureBuilder<List<dynamic>>(
            future: getCityData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.hasData);

                return GridView.builder(
                    shrinkWrap: true,
                    controller: new ScrollController(keepScrollOffset: false),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      var cityName = snapshot.data![index]['name'];
                      var company = snapshot.data![index]['company_name'];

                      return InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.ac_unit),
                                new Padding(
                                  padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 2.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                        child: Text(
                                          cityName,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                    });
              }
              return CircularProgressIndicator();
            },
          ),
        ),

      */
      ],
    );
  }

  Widget destinationType(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.only(left: 8.0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            color: color,
            size: 12.0.sp,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 8.0.sp),
          )
        ],
      ),
    );
  }
  Widget destinations(String cityName, IconData icon, Color color){
    return Padding(
      padding: EdgeInsets.fromLTRB(0.sp, 0.0.sp, 2.0.sp, 4.0.sp),
      child: Container(
        height: 12.0.h,
        width: 29.0.w,
        color: color.withOpacity(0.2.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              icon, size: 20.0.sp,
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 8.0.sp),
              child: Text(cityName, style: TextStyle(fontSize: 10.sp),),
            )
          ],
        ),
      ),
    );
  }
}
