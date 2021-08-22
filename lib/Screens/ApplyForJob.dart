import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality_92/Model/JobsModel.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:sweetalert/sweetalert.dart';

import 'DashBoard.dart';

class ApplyForJob extends StatefulWidget {
  final JobItem jobItem;

  ApplyForJob(this.jobItem);

  @override
  _ApplyForJobState createState() => _ApplyForJobState();
}

class _ApplyForJobState extends State<ApplyForJob> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController experience = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController carrier = TextEditingController();

  Map<String, String> _authData = {'carrier ': '', 'experience': '', 'salary': ''};
  File? file;

  Response? response;
  String? progress;
  Dio dio = new Dio();

  int? getUserId;
  String? getUserName;

  Future fetch() async {
    var pref = await SharedPreferences.getInstance();
    var userID = pref.getInt('userID');
    var userNames = pref.getString('userName');

    getUserId = userID;
    getUserName = userNames;
  }

  bool visible = false;

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    fetch();
    final fileName = file != null ? file!.path : '';
    String getFileName = fileName.split('/').last;

    final node = FocusScope.of(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 8.0.h,
          automaticallyImplyLeading: false,
          title: Text(
            "Job Application",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
              size: 20.0.sp,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.sp, horizontal: 10.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                              child: Text(widget.jobItem.title, style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold)),
                            )),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(widget.jobItem.company + ", Lahore", style: TextStyle(fontSize: 10.0.sp)),
                            )),
                      ],
                    ),
                  ),
                ),
                Container(child: Divider(thickness: 1.0.sp, color: Colors.black45)),
                TextFormFieldContainer(
                  TextInputType.name,
                  experience,
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your experience';
                    }
                    return null;
                  },
                  (value) {
                    _authData['experience'] = value;
                  },
                  Icons.work,
                  'Experience',
                  () => node.nextFocus(),
                ),
                TextFormFieldContainer(TextInputType.number, salary, (value) {
                  if (value.isEmpty) {
                    return '    Enter your desired salary';
                  }
                  return null;
                }, (value) {
                  _authData['salary'] = value;
                }, Icons.payments_outlined, 'Salary', () => node.nextFocus()),
                TextFormFieldContainer(TextInputType.name, carrier, (value) {
                  if (value.isEmpty) {
                    return ' Enter your Career level';
                  }
                  return null;
                }, (value) {
                  _authData['carrier '] = value;
                }, Icons.category, 'Career Level', () => node.nextFocus()),
                SizedBox(height: 2.0.h),
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
                      "Select CV",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12.sp),
                    ),
                  ),
                ),
                /*Container(
                  //width: 95.0.w,
                  child: FlatButton.icon(
                    onPressed: () {
                      uploadFile();
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
                ),*/
                //Text(fileName),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    getFileName,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Center(
                  child: Visibility(maintainSize: true, maintainAnimation: true, maintainState: true, visible: visible, child: Container(margin: EdgeInsets.only(top: 5, bottom: 3), child: CircularProgressIndicator())),
                ),

                //SizedBox(height: 50.0.sp),
                Container(
                  height: 40.0.h,
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp),
                    child: InkWell(
                      child: Center(
                          child: GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  print('validated');
                                  loadProgress();
                                  uploadFile();
                                  /*applyingForJob(usersID: getUserId.toString(), jobID: widget.jobItem.jobID.toString(), experience: experience.text, salary: salary.text, career: carrier.text, relocate: "1", document: fileName);*/
                                } else {
                                  print("Not Validated");
                                }
                                ;
                              },
                              child: Container(
                                height: 7.0.h,
                                width: 100.0.w,
                                margin: EdgeInsets.only(top: kDefaultPadding.sp / 2, left: 8.0.sp),
                                decoration: BoxDecoration(
                                  color: Color(0x8F03A9F4),
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.all(Radius.circular(8.0.sp)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Send Application",
                                  style: TextStyle(color: kButtonsTextColor, fontSize: 12.0.sp, fontWeight: FontWeight.w500, fontFamily: "Otomanopee One"),
                                ),
                              ))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['docx', 'pdf'],
    );

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  uploadFile() async {
    String uploadurl = "https://hospitality92.com/api/applyjobP";
    FormData formdata = FormData.fromMap({
      "user_id": getUserId,
      "job_id": widget.jobItem.jobID,
      "experience": "12",
      "salary": "1122378",
      "career": "Entry Level",
      "relocate": "1",
      "document": await MultipartFile.fromFile(file!.path, filename: basename(file!.path)
          //show only filename from path
          ),
    });
    response = await dio.post(
      uploadurl,
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent / total * 100).toStringAsFixed(2);
        setState(() {
          progress = percentage + " % uploaded";
          //update the progress
        });
      },
    );

    loadProgress();
    var res = response.toString();
    print("you are getting following response = " + res);
    var resp = res.substring(1, res.length - 1);
    final split = resp.split(',');
    final Map<int, String> values = {for (int i = 0; i < split.length; i++) i: split[i]};
    final value1 = values[0];
    print("dcdsccccccccccd" + value1.toString());

    if (value1 == '"status":"300"') {
      SweetAlert.show(this.context, title: "Sorry $getUserName", subtitle: "You have already applied for this Job!!", style: SweetAlertStyle.error);
    } else {
      SweetAlert.show(this.context, title: "Dear $getUserName", subtitle: "Your Job application has been sent!", style: SweetAlertStyle.success, onPress: (bool isConfirmed) {
        if (isConfirmed) Navigator.of(this.context).push(MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
        return false;
      });
    }

    print(response.toString());
    // if(response!.statusCode == 200){
    //
    //
    //
    //   //print response from server
    // }else{
    //   Fluttertoast.showToast(msg: "Something went wrong! Try again Later", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 10, backgroundColor: Colors.black54, textColor: Colors.white, fontSize: 16.0);
    //
    //   print("Error during connection to server.");
    // }
  }

  Widget TextFormFieldContainer(
    TextInputType type,
    TextEditingController controller,
    FormFieldValidator validator,
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

  Future applyingForJob({
    required String usersID,
    required String jobID,
    required String experience,
    required String salary,
    required String career,
    required String relocate,
    required String document,
  }) async {
    const url = 'https://hospitality92.com/api/applyjobP';

    print('usersID= $usersID and jobID = $jobID and experience= $experience and salary= $salary and career=$career and relocate=$relocate ');

    final response = await http.post(Uri.parse(url), body: {'user_id': usersID, 'job_id': jobID, 'experience': experience, 'salary': salary, 'career': career, 'relocate': relocate, 'document': document});

    print(response.body.toString());
    loadProgress();

    var res = response.body.substring(1, response.body.length - 1);
    final split = res.split(',');
    final Map<int, String> values = {for (int i = 0; i < split.length; i++) i: split[i]};
    final value1 = values[0];

    print(value1);
    if (value1 == '"status":"200"') {
      SweetAlert.show(this.context, title: "Dear $getUserName", subtitle: "Your Job application has been sent!", style: SweetAlertStyle.success);
    } else {
      SweetAlert.show(this.context, title: "Dear $getUserName", subtitle: "Your Job application has been sent!", style: SweetAlertStyle.success, onPress: (bool isConfirmed) {
        if (isConfirmed) Navigator.of(this.context).push(MaterialPageRoute(builder: (BuildContext context) => DashBoard()));

        return false;
      });
      Fluttertoast.showToast(msg: "Something went wrong! Try again Later", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 10, backgroundColor: Colors.black54, textColor: Colors.white, fontSize: 16.0);
    }
  }
}
