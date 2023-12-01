import 'package:fire_ui/color_page.dart';
import 'package:fire_ui/homePage.dart';
import 'package:fire_ui/image_page.dart';
import 'package:fire_ui/login.dart';
import 'package:fire_ui/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class login_signup extends StatefulWidget {
  const login_signup({super.key});

  @override
  State<login_signup> createState() => _login_signupState();
}

class _login_signupState extends State<login_signup> {
  String name = '';
  int num = 0;
  bool tap = true;
  bool login1 = false;
  // getData() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   login1 = _prefs.getBool('login')!;
  // }
  //
  // @override
  // void initState() {
  //   getData();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPage.secondaryColor,
      body: Container(
        height: width * 2.25,
        width: width * 1,
        // color: colorPage.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: width * 0.05,
            ),

            Container(
              width: width * 0.85,
              height: width * 0.8,
              // color: Colors.red,
              child: Image.asset(imagePage.image1),
            ),
            Container(
              height: width * 0.2,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "CRUD",
                    style: TextStyle(
                        fontSize: width * 0.075,
                        fontWeight: FontWeight.w700,
                        color: colorPage.primaryColor),
                  ),
                  Text(
                    "Create, Read, Update ,Delete",
                    style: TextStyle(
                        fontSize: width * 0.037,
                        fontWeight: FontWeight.w400,
                        color: colorPage.primaryColor),
                  ),
                ],
              ),
            ),
            Container(
              height: width * 0.34,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                login1 == true ? homePage() : login(),
                          ));
                    },
                    child: Container(
                      height: width * 0.13,
                      width: width * 0.65,
                      decoration: BoxDecoration(
                          color: colorPage.primaryColor,
                          borderRadius: BorderRadius.circular(width * 1)),
                      child: Center(
                        child: Text("Login",
                            style: GoogleFonts.montserrat(
                                color: colorPage.secondaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: width * 0.045)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => sign_up(),
                          ));
                    },
                    child: Container(
                      height: width * 0.13,
                      width: width * 0.65,
                      decoration: BoxDecoration(
                          // color: colorPage.secondaryColor,
                          border: Border.all(
                              color: colorPage.primaryColor,
                              width: width * 0.006),
                          borderRadius: BorderRadius.circular(width * 1)),
                      child: Center(
                        child: Text("Sign up",
                            style: GoogleFonts.montserrat(
                                color: colorPage.primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: width * 0.045)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: width * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
