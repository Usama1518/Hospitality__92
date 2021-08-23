import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OthersItems extends StatefulWidget {
  OthersItems() : super();

  @override
  _OthersItemsState createState() => _OthersItemsState();
}

class _OthersItemsState extends State<OthersItems> {
  List<String> videoLinkList = [];
  List<String> videosList = [];

  Future getVideosData() async {
    var response = await http.get(Uri.https('hospitality92.com', 'api/getvideos'));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["videos"];
    if (videosList.length != 0) videosList.clear();
    for (var i = 0; i < data.length; i++) {
      videoLinkList.add(data[i]["link"]);
      videosList.add(data[i]["video"]);
      //videosList.add('https://hospitality92.com/uploads/videos/${data[i]["video"]}');
    }
    print("Videos Response" + videosList.toString());
    print("Videos Link Response" + videoLinkList.toString());
  }

  getAllVideo() {
    for (int i = 0; i < videosList.length; i++) {
      if (videosList.elementAt(i) != null) {
        var videoItem = videosList.elementAt(i);
        videoLinkList.add(videoItem);
        print("cjsdvchdvdhcvsdhc == ");
        print("cjsdvchdvdhcvsdhc == " + videosList.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getAllVideo();
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            getAllVideo();
          }, child: Text("sddfv")),

          Text("dfvdfvdhfvdfjv"),
        ],
      ),
    );
  }
}
