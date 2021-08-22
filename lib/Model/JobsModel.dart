import 'package:flutter/material.dart';

class JobItem {
  final int jobID;
  final String title;
  final String company;
  final String description;
  final String skills;
  final String type;
  final String jobImage;
  final String career_level;
  final String category;
  final String qualification;
  final String min_experience;
  final String max_experience;
  final String min_salary;
  final String max_salary;
  final String preference;
  final String date;
  final int cityID;
  //var jobCityID = int.parse(snapshot.data![index]['city_id']) ;


  JobItem(
      {required this.jobID,
      required this.title,
        required this.company,
        required this.description,
        required this.skills,
        required this.type,
        required this.jobImage,
        required this.career_level,
        required this.category,
        required this.qualification,
        required this.min_experience,
        required this.max_experience,
        required this.min_salary,
        required this.max_salary,
        required this.preference,
        required this.date,
        required this.cityID
      });

  factory JobItem.fromDocument(AsyncSnapshot doc, index) {
    return JobItem(
      jobID: doc.data[index]['id'],
      title: doc.data[index]['title'],
      company: doc.data[index]['company_name'],
      description: doc.data[index]['description'],
      skills: doc.data[index]['skills'],
      type: doc.data[index]['type'],
      jobImage: doc.data[index]['image'],
      career_level: doc.data[index]['career_level'],
      category: doc.data[index]['category'],
      qualification: doc.data[index]['qualification'],
      min_experience: doc.data[index]['min_experience'],
      max_experience: doc.data[index]['max_experience'],
      min_salary: doc.data[index]['min_salary'],
      max_salary: doc.data[index]['max_salary'],
      preference: doc.data[index]['preference'],
      date: doc.data[index]['date'],
      cityID: int.parse(doc.data[index]['city_id']),

    );
  }
}
