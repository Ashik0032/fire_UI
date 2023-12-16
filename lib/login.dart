import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_ui/color_page.dart';
import 'package:fire_ui/google%20sing.dart';
import 'package:fire_ui/homePage.dart';
import 'package:fire_ui/image_page.dart';
import 'package:fire_ui/phone.dart';
import 'package:fire_ui/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

String? currentUserName;
String? currentUserEmail;
String? currentUserPassword;
String? currentUserid;

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool tap = true;
  // TextEditingController name_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  final emailvallidation =
      RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+");
  final passwordvallidation =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  bool tik = false;
  final formkey = GlobalKey<FormState>();
  // String name = '';
  int num = 0;
  bool tap1 = true;
  bool login1 = true;
  setData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("name", email_controller.text);
    currentUserName = _prefs.getString("name");
  }

  // getData() async {
  //   SharedPreferences _prefs =
  //   await SharedPreferences.getInstance();
  //   login1 = _prefs.getBool('login')!;
  // }
  @override
  void initState() {
    // getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPage.secondaryColor,
      // backgroundColor: Colors.yellow,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorPage.secondaryColor,
        title: Text("CRUD",
            style: TextStyle(
              fontSize: width * 0.055,
              fontWeight: FontWeight.w700,
              color: colorPage.thirdColor,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: SingleChildScrollView(
          child: Container(
            height: width * 2.25,
            width: width * 1,
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.87,
                    height: width * 0.7,
                    // color: Colors.red,
                    child: Image.asset(imagePage.image2),
                  ),
                  Container(
                    height: width * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          controller: email_controller,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                              color: colorPage.thirdColor),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: (value) {
                          //   if (!emailvallidation.hasMatch(value!)) {
                          //     return "enter valid email";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          decoration: InputDecoration(
                            labelText: "Username",
                            labelStyle: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w400,
                                color: colorPage.thirdColor),
                            hintText: "user@gmail.com ",
                            hintStyle: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.025),
                                borderSide: BorderSide(
                                  color: colorPage.thirdColor,
                                )),
                          ),
                        ),
                        TextFormField(
                          controller: password_controller,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          obscureText: tap ? true : false,
                          obscuringCharacter: '*',
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  tap = !tap;
                                  setState(() {});
                                },
                                child: Icon(tap
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontSize: width * 0.05,
                                color: colorPage.thirdColor,
                                fontWeight: FontWeight.w400),
                            hintText: "pleace enter your password",
                            hintStyle: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.025),
                                borderSide: BorderSide(
                                  color: colorPage.thirdColor,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * 0.1,
                  ),
                  Container(
                    height: width * 0.5,
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (email_controller.text == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("enter your username")));
                            } else {
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email_controller.text,
                                      password: password_controller.text)
                                  .then((value) async {
                                // getData();

                                var data = await FirebaseFirestore.instance
                                    .collection('flit')
                                    .where('email',
                                        isEqualTo: email_controller.text)
                                    .get();

                                currentUserName = data.docs[0]['name'];
                                currentUserEmail = data.docs[0]['email'];
                                currentUserPassword = data.docs[0]['password'];
                                currentUserid = data.docs[0].id;

                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => homePage()));
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(error.code.toString())));
                              });
                            }
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
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.025,
                                  ),
                                  SvgPicture.asset(imagePage.image4),
                                  SizedBox(
                                    width: width * 0.17,
                                  ),
                                  Text("Login",
                                      style: GoogleFonts.montserrat(
                                          color: colorPage.primaryColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: width * 0.045)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            AuthMethods().signInWithGoogle(context);
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
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 0.025,
                                ),
                                SvgPicture.asset(imagePage.image3),
                                SizedBox(
                                  width: width * 0.025,
                                ),
                                Text(" Sign in with Google",
                                    style: GoogleFonts.montserrat(
                                        color: colorPage.primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: width * 0.045)),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => phone(),
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
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 0.025,
                                ),
                                SvgPicture.asset(imagePage.image5),
                                SizedBox(
                                  width: width * 0.12,
                                ),
                                Text("OTP sign in",
                                    style: GoogleFonts.montserrat(
                                        color: colorPage.primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: width * 0.045)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * 0.09,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => sign_up(),
                          ));
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don’t have an account ? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: colorPage.primaryColor),
                        children: [
                          TextSpan(
                              text: "Create Now",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: colorPage.primaryColor)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
