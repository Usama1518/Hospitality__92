import 'package:flutter/material.dart';
import 'package:hospitality_92/Model/JobsModel.dart';
import 'package:sizer/sizer.dart';



class JobOverviewCard extends StatefulWidget{

  String title;
  String min_salary;
  String max_salary;
  String company;
  String type;

  JobOverviewCard( this.title,  this.min_salary,  this.max_salary,  this.company,  this.type);

  @override
  _JobOverviewCardState createState() => _JobOverviewCardState();
}

class _JobOverviewCardState extends State<JobOverviewCard> {
  late JobItem jobItem;

  @override
  Widget build(BuildContext context) {
return Container();
    /*return   GestureDetector(
      onTap: (){
        jobItem = JobItem.fromDocument(snapshot, index);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobsDetail(jobItem),
            ));
      },
      child: Padding(
        padding: EdgeInsets.only(

          left: 10.0.sp ,right: 10.0.sp, bottom: 10.0.sp, ),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(10.0.sp),
          child: Container(
            height: 13.0.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0.sp),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 10.0.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 4.0.h,

                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          */
    /*'Senior Developer'*//*
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0.sp,

                              fontWeight: FontWeight.bold),
                        ),
                      )
                  ),
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
                          width: 10.0.sp,
                        ),
                        Text(
                            "Rs. " + widget.min_salary + " - " + "Rs." + widget.max_salary  ,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0.sp,

                              fontWeight: FontWeight.w600),
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
                            Icons.location_on,
                            color: Colors.grey,
                            size: 12.0.sp,
                          ),
                          SizedBox(
                            width: 10.0.sp,
                          ),
                          Text(
                            *//*'Islamabad, Pakistan'*//*widget.company,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.0.sp,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          Container(
                            width: 18.0.w,
                            height: 3.0.h,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(6.0.sp)
                            ),
                            child: Center(
                              child: Text(
                                *//*'Full-time'*//*
                              widget.type,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.0.sp,
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                  *//*Center(
                      child: Container(
                        color: Colors.grey.withOpacity(0.3),
                        height: 1.0.sp,
                        width: 80.0.w,
                      )),
                  Container(
                    height: 3.0.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.grey,
                          size: 12.0.sp,
                        ),
                        SizedBox(
                          width: 10.0.sp,
                        ),
                        Text(
                          '8-10 years',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0.sp,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          'Sozie',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 10.0.sp,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),*//*
                ],
              ),
            ),
          ),
        ),
      ),
    );*/
  }
}