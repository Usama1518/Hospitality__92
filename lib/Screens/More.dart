import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitality_92/AccountScreens/Login_Screen.dart';
import 'package:hospitality_92/Screens/GetUserAppliedJobs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:alert_dialog/alert_dialog.dart';
import 'Jobs.dart';

class MoreSettings extends StatefulWidget {
  @override
  _MoreSettingsState createState() => _MoreSettingsState();
}

class _MoreSettingsState extends State<MoreSettings> {
  Future fetch() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("isLogIn");
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
//    fetch();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          categoryListCard('My Jobs', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GetUserAppliedJob(),
                ));
          }),
          categoryListCard('Help Center', () {}),
          categoryListCard('Contact Us', () {}),
          categoryListCard('About Us', () {}),
          categoryListCard('Sign out', () {
            //fetch();
            showAlertDialog(context);


          }),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        fetch();
        //Navigator.of(context).pop();
      },
    );

    Widget noButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("Simple Alert"),
      content: Text("Do you want to Logout ?"),
      actions: [
        okButton,
        noButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget categoryListCard(categoryName, onPress) {
    return Container(
      child: InkWell(
        onTap: onPress,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xC000000), Color(0xC000000)])),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          categoryName,
                          style: TextStyle(fontSize: 16, color: Colors.lightBlue, fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.blueGrey,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
