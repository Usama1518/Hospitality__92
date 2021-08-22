import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospitality_92/AccountScreens/Login_Screen.dart';
import 'package:sizer/sizer.dart';
import 'package:device_preview/device_preview.dart';
import 'AccountScreens/Signup_Screen.dart';
import 'AccountScreens/Signup_Screen_Two.dart';
import 'Screens/DashBoard.dart';
import 'Screens/SplashScreen.dart';

void main() =>
    runApp(
      DevicePreview(
          builder: (context) => MyApp(),
          enabled: !kReleaseMode,
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hospitality92',
          theme: ThemeData(
              primarySwatch: Colors.lightBlue
          ),
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => SplashScreen(),
            '/Signup_Screen_Two': (BuildContext context) => SignUpScreenTwo(),
          },
        );
      },
    );
  }
}
