import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/constants.dart';

class ForgetPasswordScreen extends StatefulWidget {

  static const routeName= '/forget_password_screen';

  @override
  _ForgetPasswordScreenState createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState
    extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp*2, vertical: kDefaultPadding.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Container(

                      height: 45.0.h,
                      width: 100.0.w,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.lock_outline_rounded, size: 100.0.sp, color: Colors.white,),
                          Text(
                            "Forget Password ?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0.sp,
                                color: Colors.white,
                                fontFamily: "Otomanopee One",
                                fontWeight: FontWeight.bold),

                          ),
                          SizedBox(height: kDefaultPadding.sp,),
                          Text(
                            "Provide Your Account E-Mail To Reset Password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.white,
                                fontFamily: "Mulish",
                                fontWeight: FontWeight.w500),

                          )],
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPadding*2,
                    ),
                    Container(
                      height: 7.0.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0.sp)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp/2),
                          child: Center(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '    Enter E-Mail';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontFamily: "Mulish",
                                fontSize: 12.0.sp,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,

                                errorStyle:
                                TextStyle(fontSize: 6.0.sp, fontFamily: 'Merriweather Sans'),
                                hintText: 'E-Mail',
                                hintStyle: TextStyle(fontFamily: "Mulish", fontSize: 10.0.sp),
                                prefixIcon: Icon(
                                  Icons.email,
                                  size: 18.0.sp,
                                ),
                              ),
                            ),
                          ),
                        ),

                    ),
                    SizedBox(
                      height: kDefaultPadding.sp,
                    ),
                    InkWell(
                        child: Center(
                            child: GestureDetector(
                                onTap: () {
                                  if (formkey.currentState!.validate()) {
                                    print("Validated");
                                  } else {
                                    print("Not Validated");
                                  }
                                  ;
                                },
                                child: Container(
                                  height: 6.0.h,
                                  width: double.infinity,
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
                                        fontWeight: FontWeight.bold, ),
                                  ),
                                ))),

                    ),

                  ],
                ),
              ),
            )));
  }
}
