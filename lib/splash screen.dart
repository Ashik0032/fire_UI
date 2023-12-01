import 'package:fire_ui/color_page.dart';
import 'package:fire_ui/homePage.dart';
import 'package:fire_ui/image_page.dart';
import 'package:fire_ui/login_signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {

  bool login1=false;

  // getData() async {
  //   SharedPreferences _prefs =
  //   await SharedPreferences.getInstance();
  //   login1 = _prefs.getBool('login')??false;
  //   Future.delayed(Duration(seconds: 2))
  //       .then((value) => Navigator.pushReplacement(
  //       context,
  //       CupertinoPageRoute(
  //         builder: (context) =>login1== false?login_signup():homePage(),
  //         // builder: (context) =>login1!=true?login_signup():homePage(),
  //       )));
  // }
  getData() async {
    SharedPreferences abc=await SharedPreferences.getInstance();
    name =abc.getString("name")??"";

    Future.delayed(Duration(seconds: 4)).then((value) =>
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => name==""?login_signup():homePage(),)));
  }
  @override
  void initState() {
    // getData();
    getData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPage.secondaryColor,
      body: Container(
        height: width * 2.25,
        width: width * 1,
        // color: colorPage.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: width * 0.5,
            ),
            Container(
              width: width * 0.85,
              height: width * 0.8,
              // color: Colors.red,
              child: Image.asset(imagePage.image1),
            ),
            CircularProgressIndicator(
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
