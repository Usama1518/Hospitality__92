import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';
import 'dart:convert';
import 'Login_Screen.dart';
import '../Utils/constants.dart';
import 'Signup_Screen_Two.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController fullName = TextEditingController();
  TextEditingController desiredJobTitle = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  Map<String, String> _authData = {'email': '', 'password': '', 'fullName': 'fullName', 'desiredJobTitle': 'desiredJobTitle', 'phone':'phone' };



  @override
  Widget build(BuildContext context) {
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
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: kDefaultPadding.sp / 2,
                horizontal: kDefaultPadding.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 20.0.h,
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
                TextFormFieldContainer(
                  TextInputType.name,
                  fullName,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return '    Enter Name';
                    } else if (value.length < 3) {
                      return '    Name must be greater than 2 characters';
                    }
                    return null;
                  },
                  (value) {
                    _authData['fullName'] = value;
                  },
                  Icons.person,
                  'Full-Name',
                  () => node.nextFocus(),
                ),
                TextFormFieldContainer(TextInputType.text, desiredJobTitle,
                        (value) {
                      if (value.isEmpty) {
                        return '    Enter Job Title';
                      }

                      return null;
                    },
                    (value) {
                  _authData['desiredJobTitle'] = value;
                }, Icons.work, 'Desired Job Title', () => node.nextFocus()),
                TextFormFieldContainer(TextInputType.emailAddress, email,
                        (value) {
                      if (value.isEmpty) {
                        return '    Enter E-Mail';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return '    Enter valid E-mail';
                      }
                      return null;
                    },
                        (value) {
                      _authData['email'] = value;
                    }, Icons.email, 'E-Mail', () => node.nextFocus()),
                TextFormFieldContainer(TextInputType.phone, phone,
                        (value) {
                      if (value.isEmpty) {
                        return '    Enter Mobile Number';
                      }

                      return null;
                    },
                        (value) {
                      _authData['phone'] = value;
                    }, Icons.phone, 'Mobile Number', () => node.nextFocus()),

                SizedBox(
                  height: 8.0.h
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp),
                  child: InkWell(
                    child: Center(
                        child: GestureDetector(
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                print('validated');
                                print(fullName.text);
                                print(desiredJobTitle.text);
                                print(phone.text);
                                print(email.text);
                                /*Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreenTwo(fullName.text,desiredJobTitle.text, email.text, phone.text),
                                    ));*/
                                Navigator.of(context).pushNamed(SignUpScreenTwo.routeName,
                                    arguments: {'fName':fullName.text, 'email': email.text, 'jobTitle':desiredJobTitle.text, 'phone':phone.text}
                                );

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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0.sp)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    color: kButtonsTextColor,
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Otomanopee One"),
                              ),
                            ))),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding.sp / 3,
                ),
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already A Member?",
                            style: TextStyle(
                                color: kButtonsTextColor,
                                fontFamily: "Mulish",
                                fontSize: 9.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "  Login",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontFamily: "Mulish",
                                fontSize: 11.0.sp,
                                fontWeight: FontWeight.bold),
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
                ),
                SizedBox(
                  height: kDefaultPadding.sp,
                ),
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
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding.sp / 2,
            vertical: kDefaultPadding.sp / 3),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            keyboardType: type,
            controller: controller,
            validator: validator,
           // onSaved: onSave,
            style: TextStyle(
              fontFamily: "Mulish",
              fontSize: 12.0.sp,
            ),
            decoration: InputDecoration(
              errorStyle:
              TextStyle(fontSize: 6.0.sp, fontFamily: 'Merriweather Sans'),
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
      style: TextStyle(
          fontSize: 12.0.sp,
          color: Colors.white,
          fontFamily: "Otomanopee One",
          fontWeight: FontWeight.bold),
    );
  }
}
