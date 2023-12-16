import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_ui/color_page.dart';
import 'package:fire_ui/homePage.dart';
import 'package:fire_ui/image_page.dart';
import 'package:fire_ui/login.dart';
import 'package:fire_ui/sharedPreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  bool tap = true;
  TextEditingController name_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController password_controller1 = TextEditingController();
  final emailvallidation =
      RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+");
  final passwordvallidation =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final formkey = GlobalKey<FormState>();
  var file;
  pickFile(ImageSource) async {
    final imageFile = await ImagePicker.platform.pickImage(source: ImageSource);
    file = File(imageFile!.path);
    if (mounted) {
      setState(() {
        file = File(imageFile.path);
      });
    }
  }

  String number = '';
  String name = '';
  int num = 0;
  getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    number = _prefs.getString("number").toString();
    name = _prefs.getString("name").toString();
    num = _prefs.getInt('num')!;
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPage.secondaryColor,
      // backgroundColor: Colors.yellow,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorPage.secondaryColor,
        leading: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                height: width * 0.03,
                width: width * 0.03,
                child: SvgPicture.asset(imagePage.image6)),
          ),
        ),
        title: Text("User Registration",
            style: TextStyle(
              fontSize: width * 0.055,
              fontWeight: FontWeight.w500,
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
                  Stack(
                    children: [
                      file != null
                          ? Container(
                              height: width * 0.4,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: FileImage(file),
                                      fit: BoxFit.cover)),
                            )
                          : CircleAvatar(
                              radius: width * 0.19,
                              backgroundColor: colorPage.secondaryColor,
                              backgroundImage: AssetImage(imagePage.image11),
                              // backgroundColor: colorPage.primaryColor,
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            showCupertinoModalPopup(
                              barrierColor: colorPage.sixColor,
                              context: context,
                              builder: (context) {
                                return CupertinoActionSheet(
                                  actions: [
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        pickFile(ImageSource.gallery);
                                      },
                                      child: Text("Photo Gallery",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: width * 0.05)),
                                      isDefaultAction: true,
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        pickFile(ImageSource.camera);
                                      },
                                      child: Text("Camera",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: width * 0.05)),
                                      isDefaultAction: true,
                                    ),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: width * 0.05),
                                      )),
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            radius: width * 0.05,
                            backgroundColor: colorPage.primaryColor,
                            child: SvgPicture.asset(imagePage.image10),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: width * 0.05,
                  ),
                  Container(
                    height: width * 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: name_controller,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            fillColor: colorPage.fiveColor,
                            filled: true,
                            suffixIcon: Icon(Icons.person_outline,
                                size: width * 0.08,
                                color: colorPage.sevenColor),
                            labelText: "Full name",
                            labelStyle: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w300,
                                color: colorPage.sixColor),
                            hintText: "Enter your name",
                            hintStyle: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.03),
                                borderSide: BorderSide()),
                          ),
                        ),
                        TextFormField(
                          controller: email_controller,
                          // textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: (value) {
                          //   if(!emailvallidation.hasMatch(value!))
                          //   {
                          //     return "enter valid email";
                          //
                          //   }
                          //   else{
                          //     return null;
                          //   }
                          // },
                          decoration: InputDecoration(
                            fillColor: colorPage.fiveColor,
                            filled: true,
                            suffixIcon: Icon(Icons.mail_outline,
                                size: width * 0.08,
                                color: colorPage.sevenColor),
                            labelText: "Valid email",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: colorPage.sixColor),
                            hintText: "Enter your email",
                            hintStyle: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.03),
                                borderSide: BorderSide()),
                          ),
                        ),
                        TextFormField(
                          controller: password_controller,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          // obscuringCharacter: "*",
                          // maxLength: 8,
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            fillColor: colorPage.fiveColor,
                            filled: true,
                            suffixIcon: Icon(Icons.lock_outline,
                                size: width * 0.08,
                                color: colorPage.sevenColor),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: colorPage.sixColor),
                            hintText: "Enter your password",
                            hintStyle: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.03),
                                borderSide: BorderSide()),
                          ),
                        ),
                        TextFormField(
                          controller: password_controller1,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          // obscuringCharacter: "*",
                          // maxLength: 8,
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            fillColor: colorPage.fiveColor,
                            filled: true,
                            suffixIcon: Icon(Icons.lock_outline,
                                size: width * 0.08,
                                color: colorPage.sevenColor),
                            labelText: "Confirm Password",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: colorPage.sixColor),
                            hintText: "Enter your password",
                            hintStyle: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.03),
                                borderSide: BorderSide()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      if (name_controller.text != "" &&
                          email_controller.text != "" &&
                          password_controller.text != "") {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email_controller.text,
                                password: password_controller.text)
                            .then((value) {
                          FirebaseFirestore.instance.collection('flit').add({
                            "name": name_controller.text,
                            "email": email_controller.text,
                            "password": password_controller.text,
                            'images':
                                "https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png"
                          });
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => homePage(),
                              ));
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.code.toString())));
                        });

                        // FirebaseAuth.instance.createUserWithEmailAndPassword(email: email_controller.text, password: password_controller.text).then((value) {

                        // });
                      } else {
                        name_controller.text == ""
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("enter your name!")))
                            : email_controller.text == ""
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("enter your email!")))
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("enter your password!")));
                      }

                      // FirebaseFirestore.instance.collection('users').doc('user001').set(
                      //                    {
                      //                      'name':"ashik123",
                      //                      "email":"muhammedashik480@gmail.com",
                      //                      "password":"8129033200"
                      //                    }
                      //                  );
                    },
                    //   onTap: () async {
                    //     SharedPreferences _prefs
                    //   =await SharedPreferences.getInstance();
                    //    _prefs.setBool("login", true);
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Success")));
                    //   },
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
                        child: Text("Sign Up",
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
          ),
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => login(),
              ));
        },
        child: Container(
          height: 60,
          color: colorPage.secondaryColor,
          child: Center(
            child: RichText(
              text: TextSpan(
                text: "Already have an Account ",
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: colorPage.thirdColor),
                children: [
                  TextSpan(
                      text: "Login?",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: colorPage.primaryColor)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
