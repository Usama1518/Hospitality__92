import 'package:flutter/cupertino.dart';

class BlogsItem {
  int blogID;
  String bloggerName;
  String bloggDescription;
  String bloggerQuote;
  String bloggerReview;
  String bloggerImage;
  //String blogVideo;
//  String blogVideoLink;
  String blogDate;
  String blogCreated_at;
  String blogUpdated_at;

  BlogsItem(
      {required this.blogID,
      required this.bloggerName,
      required this.bloggDescription,
      required this.bloggerQuote,
      required this.bloggerReview,
      required this.bloggerImage,
    //  required this.blogVideo,
    //  required this.blogVideoLink,
      required this.blogDate,
      required this.blogCreated_at,
      required this.blogUpdated_at});

  factory BlogsItem.fromDocument(AsyncSnapshot doc, index) {
    return BlogsItem(
      blogID: doc.data[index]['id'],
      bloggerName: doc.data[index]['name'],
      bloggDescription: doc.data[index]['description'],
      bloggerQuote: doc.data[index]['quote'],
      bloggerReview: doc.data[index]['review'],
      bloggerImage: doc.data[index]['image'],
    //  blogVideo: doc.data[index]['video'],
     // blogVideoLink: doc.data[index]['link'],
      blogDate: doc.data[index]['date'],
      blogCreated_at: doc.data[index]['created_at'],
      blogUpdated_at: doc.data[index]['updated_at'],
    );
  }
}
