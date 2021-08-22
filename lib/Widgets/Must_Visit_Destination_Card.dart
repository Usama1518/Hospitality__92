import 'package:flutter/material.dart';
import 'package:hospitality_92/Model/Must_Visit_Destinations.dart';
import 'package:sizer/sizer.dart';

import '../Utils/constants.dart';

class MustVisitDestinationCard extends StatelessWidget {
  final MustVisitDestinations mustVisitDestinations;

  const MustVisitDestinationCard({required this.mustVisitDestinations});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kDefaultPadding.sp / 2, top: kDefaultPadding.sp / 5, bottom: kDefaultPadding.sp / 5),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(kBorderRadius.sp / 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius.sp / 2),
          ),
          width: 30.0.w,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(kBorderRadius.sp / 2)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(kBorderRadius.sp / 2),
                      child: Image.network(
                        mustVisitDestinations.imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )),
                ),
              ),
              Container(
                height: 3.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kBorderRadius.sp / 2),
                ),
                child: Center(
                    child: Text(
                  mustVisitDestinations.name,
                  style: TextStyle(fontSize: 8.0.sp, fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
