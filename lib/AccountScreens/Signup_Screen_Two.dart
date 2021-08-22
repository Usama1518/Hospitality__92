import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';
import 'dart:convert';
import 'Login_Screen.dart';
import '../Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreenTwo extends StatefulWidget {
  static const routeName = '/Signup_Screen_Two';

  @override
  _SignUpScreenTwoState createState() => _SignUpScreenTwoState();
}

class _SignUpScreenTwoState extends State<SignUpScreenTwo> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController dOBController = TextEditingController();
  final dateOfBirth = MaskTextInputFormatter(mask: '00-00-0000');

  int gender = 0;
  late String genderSelected;
  Map<String, String> _authData = {
    'password': '',
    'dob': '',
  };

  bool visible = false ;
  loadProgress(){
    if(visible == true){
      setState(() {
        visible = false;
      });
    }
    else{
      setState(() {
        visible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final fullName = routeArgs['fName'];
    final userEmail = routeArgs['email'];
    final userJobTitle = routeArgs['jobTitle'];
    final userPhone = routeArgs['phone'];
    final node = FocusScope.of(context);


    return Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 8.0.h,
          backgroundColor: kSecondaryColor,
          automaticallyImplyLeading: false,
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
          key: formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding.sp / 2, horizontal: kDefaultPadding.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 15.0.h,
                  width: 60.0.w,
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeadingText('Welcome To'),
                          Text('Carriera', style: TextStyle(fontSize: 26.0.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      )),
                ),
                SizedBox(height: kDefaultPadding.sp / 5),
                TextFormFieldContainer(TextInputType.visiblePassword, password, (value) {
                  Pattern pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
                  RegExp regex = new RegExp(pattern.toString());
                  print(value);
                  if (value.isEmpty) {
                    return '    Enter Password';
                  } else {
                    if (!regex.hasMatch(value)) return '    Minimum 6 Characters with Letters And Numbers';
                  }
                  return null;
                }, (value) {
                  _authData['password'] = value;
                }, Icons.lock, 'Password', () => node.nextFocus()),
                TextFormFieldContainer(TextInputType.visiblePassword, confirmpassword, (value) {
                  if (value.isEmpty) {
                    return 'Re-enter Password';
                  }
                  if (password.text != confirmpassword.text) {
                    return "Password Does Not Match";
                  }
                  return null;
                }, (value) {
                  _authData['password'] = value;
                }, Icons.lock_outlined, 'Confirm Password', () => node.nextFocus()),
               // SizedBox(height: kDefaultPadding.sp / 5),

                Container(
                  height: 7.0.h,
                  margin: EdgeInsets.only(
                    top: kDefaultPadding.sp / 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0.sp)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp / 2, vertical: kDefaultPadding.sp / 3),
                    child: TextFormField(
                      inputFormatters: [DateInputFormatter()],
                      keyboardType: TextInputType.number,
                      controller: dOBController,
                      style: TextStyle(fontSize: 10.0.sp),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.calendar_today, size: 18.0.sp),
                        hintText: 'Date Of Birth',
                        errorStyle: TextStyle(fontSize: 6.0.sp, fontFamily: 'Merriweather Sans'),
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 15.0.h,
                  margin: EdgeInsets.only(top: kDefaultPadding.sp / 2),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0.sp))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: RadioListTile(
                          value: 0,
                          groupValue: gender,
                          title: Text(
                            "Male",
                            style: TextStyle(fontSize: 10.0.sp, fontFamily: "Mulish", color: kButtonsTextColor, fontWeight: FontWeight.bold),
                          ),
                          onChanged: (newValue) => setState(() => gender = newValue as int),
                          activeColor: Colors.deepOrange,
                          selected: false,
                          //onChanged: (int? value) {},
                        ),
                      ),
                      Flexible(
                          flex: 1,
                          child: RadioListTile(
                            value: 1,
                            groupValue: gender,
                            title: Text(
                              "Female",
                              style: TextStyle(fontSize: 10.0.sp, fontFamily: "Mulish", color: kButtonsTextColor, fontWeight: FontWeight.bold),
                            ),
                            onChanged: (newValue) => setState(() => gender = newValue as int),
                            activeColor: Colors.deepOrange,
                            selected: false,
                            // onChanged: (int? value) {},
                          )),
                      Flexible(
                          flex: 1,
                          child: RadioListTile(
                            value: 2,
                            groupValue: gender,
                            title: Text(
                              "Other",
                              style: TextStyle(fontSize: 10.0.sp, fontFamily: "Mulish", color: kButtonsTextColor, fontWeight: FontWeight.bold),
                            ),
                            onChanged: (newValue) => setState(
                              () => gender = newValue as int,
                            ),
                            activeColor: Colors.deepOrange,
                            selected: false,
                            //onChanged: (int? value) {},
                          )),
                    ],
                  ),
                ),
                SizedBox(height: kDefaultPadding.sp / 2),
                Center(
                  child: Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(top: 5, bottom: 12),
                          child: CircularProgressIndicator(color: Colors.white,)
                      )
                  ),
                ),

                Container(
                  alignment: Alignment.bottomCenter,
                  height: 10.0.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp),
                    child: InkWell(
                      child: Center(
                          child: GestureDetector(
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  loadProgress();
                                  print('validated and registering');
                                  if (gender == 0) {
                                    genderSelected = "Male";
                                    print(genderSelected);
                                  } else if (gender == 1) {
                                    genderSelected = "female";
                                    print(genderSelected);
                                  } else {
                                    genderSelected = "others";
                                    print(genderSelected);
                                  }

                                  signUp(name: fullName.toString(), jobTitle: userJobTitle.toString(), email: userEmail.toString(), password: password.text, phoneNumber: userPhone.toString(), dob: dOBController.text, gender: genderSelected.toString());

                                } else {
                                  print("Not Validated");
                                }
                                ;
                              },
                              child: Container(
                                height: 6.0.h,
                                width: 50.0.w,
                                decoration: BoxDecoration(
                                  color: kButtonsColor,
                                  borderRadius: BorderRadius.all(Radius.circular(15.0.sp)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Register",
                                  style: TextStyle(color: kButtonsTextColor, fontSize: 14.0.sp, fontWeight: FontWeight.w500, fontFamily: "Otomanopee One"),
                                ),
                              ))),
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding.sp / 3),
                //Text(fullName!,style: TextStyle(color: Colors.white),),
                GestureDetector(
                    onTap: () {
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));*/
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already A Member?",
                            style: TextStyle(color: kButtonsTextColor, fontFamily: "Mulish", fontSize: 9.0.sp, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "  Login",
                            style: TextStyle(color: kPrimaryColor, fontFamily: "Mulish", fontSize: 11.0.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    )),
                Center(
                  child: Container(
                    height: 1.0.sp,
                    width: 20.0.w,
                    color: Colors.white70,
                    margin: EdgeInsets.only(top: kDefaultPadding.sp / 4),
                  ),
                )
              ],
            ),
          ),
        )));
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
      margin: EdgeInsets.only(
        top: kDefaultPadding.sp / 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0.sp)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp / 2, vertical: kDefaultPadding.sp / 3),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            keyboardType: type,
            controller: controller,
            validator: validator,
            //onSaved: onSave,
            style: TextStyle(
              fontFamily: "Mulish",
              fontSize: 12.0.sp,
            ),
            decoration: InputDecoration(
              errorStyle: TextStyle(fontSize: 6.0.sp, fontFamily: 'Merriweather Sans'),
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

  Widget HeadingText(String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 12.0.sp, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Future signUp({
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

    final response = await http.post(Uri.parse(url), body: {'name': name, 'jobtitle': jobTitle, 'email': email, 'password': password, 'mobile': phoneNumber, 'dob': dob, 'gender': gender});

    var res = response.body.substring(1, response.body.length - 1);
    final split = res.split(',');
    final Map<int, String> values = {for (int i = 0; i < split.length; i++) i: split[i]};
    final value1 = values[0];
    if (value1.toString() == '"status":"403"') {
      loadProgress();
      Fluttertoast.showToast(msg: "Email Already exist", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 10, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
    } else {
      loadProgress();
      Fluttertoast.showToast(msg: "SignUp Successful", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 2, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 16.0);
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));

    }
    print(response.body.toString());
  }
}




