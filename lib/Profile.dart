import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

class profile extends StatefulWidget {
  const profile(
      {super.key,
      required this.name1,
      required this.email,
      required this.password});
  final String name1;
  final String email;
  final String password;

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  bool tap = true;
  TextEditingController name_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
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

  void initState() {
    name_controller.text = widget.name1;
    email_controller.text = widget.email;
    password_controller.text = widget.password;
    // TODO: implement initState
    super.initState();
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
        title: Text("Profile",
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
                              color: colorPage.tenColor),
                          decoration: InputDecoration(
                            labelText: "User name",
                            labelStyle: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w300,
                                color: colorPage.tenColor),
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
                              color: colorPage.tenColor),
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
                            labelText: "Email",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: colorPage.tenColor),
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
                          obscureText: tap ? true : false,
                          obscuringCharacter: '*',
                          style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w500,
                              color: colorPage.tenColor),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  tap = !tap;
                                  setState(() {});
                                },
                                child: Icon(
                                  tap
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: colorPage.tenColor,
                                )),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontSize: width * 0.05,
                                color: colorPage.tenColor,
                                fontWeight: FontWeight.w300),
                            hintText: "Enter your password",
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
                    height: width * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      showCupertinoModalPopup(
                        barrierColor: colorPage.sixColor,
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            content: Text(
                                "Are you Sure\nYou Want to Update Details?",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: width * 0.045)),
                            actions: [
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"),
                              ),
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("flit")
                                      .doc(currentUserid)
                                      .update({
                                    'name': name_controller.text,
                                    "email": email_controller.text,
                                    "password": password_controller.text,
                                  });
                                  currentUserName = name_controller.text;

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => homePage(),
                                      ),
                                      (route) => false);
                                },
                                child: Text("Confirm"),
                              ),
                            ],
                          );
                        },
                      );
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
                        child: Text("Update",
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
