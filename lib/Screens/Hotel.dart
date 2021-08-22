import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class Hotel extends StatefulWidget {
  @override
  _HotelState createState() => _HotelState();
}

class _HotelState extends State<Hotel> {

  Future<List<dynamic>> getCityData() async {
    String url = 'https://hospitality92.com/api/getcities';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return json.decode(response.body)['cities'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.sp, 0.0.sp, 2.0.sp, 4.0.sp),
                        child: Container(
                          height: 12.0.h,
                          width: 29.0.w,
                          color: Colors.greenAccent.withOpacity(0.2.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.mosque, size: 20.0.sp,
                              ),
                              Padding(
                                padding:  EdgeInsets.only(bottom: 8.0.sp),
                                child: Text(cityName, style: TextStyle(fontSize: 10.sp),),
                              )
                            ],
                          ),
                        ),
                      ));
                });
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
