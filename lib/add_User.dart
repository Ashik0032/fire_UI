import 'dart:io';

import 'package:fire_ui/color_page.dart';
import 'package:fire_ui/homePage.dart';
import 'package:fire_ui/image_page.dart';
import 'package:fire_ui/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

class add_User extends StatefulWidget {
  const add_User({super.key});

  @override
  State<add_User> createState() => _add_UserState();
}

class _add_UserState extends State<add_User> {
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
    final imageFile=await ImagePicker.platform.pickImage(source: ImageSource);
    file=File(imageFile!.path);
    if(mounted){
      setState(() {
        file=File(imageFile.path);
      });
    }
  }
  @override
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
        title: Text("Add User",
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
                        top: width * 0.28,
                        left: width * 0.22,
                        child: InkWell(
                          onTap: () {
                            showCupertinoModalPopup(
                              barrierColor: colorPage.sixColor,
                              context: context, builder: (context) {
                              return CupertinoActionSheet(
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      pickFile(ImageSource.gallery);
                                    }, child: Text("Photo Gallery",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: width*0.05
                                      )),
                                    isDefaultAction: true,),
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      pickFile(ImageSource.camera);
                                    }, child: Text("Camera",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: width*0.05
                                      )),
                                    isDefaultAction: true,),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);

                                    }, child: Text("Cancel",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: width*0.05
                                  ),)),
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
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => homePage(),));
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
                        child: Text("Add User",
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
    );
  }
}

