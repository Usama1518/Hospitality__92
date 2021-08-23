import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospitality_92/Screens/DashBoard.dart';
import 'package:hospitality_92/Screens/Forget_Password_Screen.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Utils/constants.dart';
import 'Signup_Screen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Map<String, String> _authData = {'email': '', 'password': ''};

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
    final node = FocusScope.of(context);
    return Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 8.0.h,
          backgroundColor: kSecondaryColor,
          automaticallyImplyLeading: false,
          title: Text(""),
          leading: IconButton(
            icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
                size: 20.0.sp
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
                      //color: Colors.pinkAccent,
                      height: 20.0.h,
                      width: 60.0.w,
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HeadingText('Login To'),
                              Text('Carriera', style: TextStyle(fontSize: 24.0.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          )),
                    ),
                    SizedBox(
                        height: kDefaultPadding.sp / 2
                    ),
                    TextFormFieldContainer(
                      TextInputType.emailAddress,
                      email,
                          (value) {
                        _authData['email'] = value;
                      },
                      Icons.email,
                      'E-Mail',
                          () => node.nextFocus(),
                    ),
                    TextFormFieldContainer(TextInputType.visiblePassword, password, (value) {
                      _authData['password'] = value;
                    }, Icons.lock, 'Password', () => node.nextFocus()),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen(),
                            ));
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: kDefaultPadding.sp / 2),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Color(0xfff6f6f6), fontFamily: "Merriweather Sans", fontSize: 10.0.sp, fontWeight: FontWeight.w500),
                          )),
                    ),
                    SizedBox(
                        height: kDefaultPadding.sp * 2
                    ),

                    Center(
                      //color: Colors.white,
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

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.sp),
                      child: Center(
                        child: InkWell(
                            splashColor: Colors.black12,
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                loadProgress();
                                loginUser(email.text, password.text);
                                print('validated');
                              } else {
                                print("Not Validated");
                              }
                              ;
                            },
                            child: Container(
                              height: 6.0.h,
                              width: 50.0.w,
                              decoration: BoxDecoration(
                                color: Color(0xff2ecc71),
                                borderRadius: BorderRadius.all(Radius.circular(15.0.sp)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Login",
                                style: TextStyle(color: Color(0xfff6f6f6), fontSize: 14.0.sp, fontWeight: FontWeight.w500, fontFamily: "Otomanopee One"),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding.sp * 5),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ));
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Don't have an Account ?",
                                    style: TextStyle(color: Color(0xfff6f6f6), fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: "  Register",
                                    style: TextStyle(color: kPrimaryColor, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
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

  Widget TextFormFieldContainer(TextInputType type,
      TextEditingController controller,
      Function onSave,
      
      IconData icon,
      String hint,
      Function moveFocus,) {
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
            obscureText: false,
            keyboardType: type,
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '    This Field Cannot Be Empty';
              }
              return null;
            },
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
      style: TextStyle(fontSize: 16.0.sp, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Future<void> loginUser(String email,
      String password,) async {
    const url = 'https://hospitality92.com/api/login';

    final pref = await SharedPreferences.getInstance();
    pref.setBool("isLogIn", true);

    print('email = $email and password= $password');
    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }));

    var res = response.body.substring(1, response.body.length - 1);
    final split = res.split(',');
    final Map<int, String> values = {for (int i = 0; i < split.length; i++) i: split[i]};
    final value1 = values[0];


    if (value1.toString() == '"status":"403"') {
      loadProgress();
      Fluttertoast.showToast(msg: "Invalid Username or Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (value1.toString() == '"status":"400"') {
      loadProgress();
      Fluttertoast.showToast(msg: "Your account has been blocked",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    else {
      loadProgress();
      Fluttertoast.showToast(msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      //pr.show();
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DashBoard()));

    }

    print("Following is res:-" + response.body.toString());

    Map<String, dynamic> map = json.decode(response.body);
    print("getting data= " + map["userdata"]["name"]);

    pref.setInt("userID", map["userdata"]["id"]);
    pref.setString("userName", map["userdata"]["name"]);
    pref.setString("userJobTitle", map["userdata"]["jobtitle"]);
    pref.setString("userDOB", map["userdata"]["dob"]);
    pref.setString("userEmail", map["userdata"]["email"]);
    pref.setString("userMobile", map["userdata"]["mobile"]);

  }
}
