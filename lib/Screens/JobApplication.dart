import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:file_picker/file_picker.dart';
import '../Model/JobsModel.dart';
import '../Utils/constants.dart';

class JobApplication extends StatefulWidget {
  final JobItem jobItem;

  JobApplication(this.jobItem);

  @override
  _JobApplicationState createState() => _JobApplicationState();
}

class _JobApplicationState extends State<JobApplication> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController fName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController career = TextEditingController();

  Map<String, String> _authData = {'fName': '', 'lastName': '', 'phoneNo': '', 'email': '',
    'experience': '', 'salary': '', 'career': '',

  };

  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? file!.path : '';

    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios, color: Colors.white,),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(widget.jobItem.title, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                          )),
                      Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(widget.jobItem.company + ", Lahore", style: TextStyle(fontSize: 8.sp)),
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                child: Divider(thickness: 2, color: Colors.black45),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                  child: Text(
                    "Add your contact \nInformation",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0.sp, vertical: 8.0.sp),
                child: Column(
                  children: [

                    TextFormFieldContainer(TextInputType.text, experience, (value) {
                      _authData['experience'] = value;
                    }, Icons.ac_unit, 'Experience', () => node.nextFocus()),

                    TextFormFieldContainer(TextInputType.text, salary, (value) {
                      _authData['salary'] = value;
                    }, Icons.ac_unit, 'Salary', () => node.nextFocus()),

                    TextFormFieldContainer(TextInputType.text, career, (value) {
                      _authData['career'] = value;
                    }, Icons.ac_unit, 'Career', () => node.nextFocus()),


                  ],
                ),
              ),
              Container(
                //width: 95.0.w,
                child: FlatButton.icon(
                  onPressed: () {
                    selectFile();
                  },
                  icon: Icon(
                    Icons.file_copy_outlined,
                    color: Colors.black,
                    size: 14.sp,
                  ),
                  label: Text(
                    "Upload CV",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12.sp),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    fileName,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.sp),
                  )),
              Container(
                height: 7.0.h,
                width: 95.0.w,
                margin: EdgeInsets.only(top: kDefaultPadding.sp / 2, left: 8.0.sp),
                decoration: BoxDecoration(
                  color: Color(0x8F03A9F4),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(8.0.sp)),
                ),
                child: FlatButton(
                  onPressed: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));*/



                  },
                  child: Text(
                    "Apply Now",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.sp),
                  ),
                ),
              ),
              SizedBox(height: 15.h,)
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }


Future applyForJob({
  required String name,
  required String email,
  required String password,
  required String phoneNumber,
  required String jobTitle,
  required String gender,
  required String dob,
}) async {
  const url = 'https://hospitality92.com/api/signup';

  print('name= $name and email = $email and password= $password and phoneNumber= $phoneNumber and jobTitle=$jobTitle');

  final response = await http.post(Uri.parse(url),
      body: {'name': name, 'jobTitle': jobTitle, 'email': email, 'password': password,
        'mobile': phoneNumber, 'dob': dob, 'gender': gender});
  print(response.body.toString());


}


  Widget TextFormFieldContainer(
    TextInputType type,
    TextEditingController controller,
    Function onSave,
    IconData icon,
    String hint,
    Function moveFocus,
  ) {
    return Container(
      height: 7.0.h,
      margin: EdgeInsets.only(top: kDefaultPadding.sp / 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(8.0.sp)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp / 2, vertical: kDefaultPadding.sp / 3),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            keyboardType: type,
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '    This Field Cannot Be Empty';
              }
              return null;
            },
            //onSaved: onSave,
            style: TextStyle(
              fontFamily: "Mulish",
              fontSize: 12.0.sp,
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(fontSize: 6.0.sp, color: Colors.red),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(fontFamily: "Mulish", fontSize: 10.0.sp),
              prefixIcon: Icon(
                icon,
                size: 18.0.sp,
              ),
            ),
            // onEditingComplete: moveFocus,
          ),
        ),
      ),
    );
  }
}
