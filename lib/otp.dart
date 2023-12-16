import 'dart:math';

import 'package:fire_ui/color_page.dart';
import 'package:fire_ui/homePage.dart';
import 'package:fire_ui/image_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import 'main.dart';

class otp extends StatefulWidget {
   final String verificationid;
   otp({super.key,required this.verificationid});

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  TextEditingController otp_controller = TextEditingController();
  // bool tap=true;
  int index = 0;
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
                  child: Center(child: SvgPicture.asset(imagePage.image6))),
            )),
        title: Text("Verify OTP",
            style: TextStyle(
              fontSize: width * 0.055,
              fontWeight: FontWeight.w500,
              color: colorPage.thirdColor,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: width * 2.25,
            width: width * 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.87,
                  height: width * 0.7,
                  // color: Colors.red,
                  child: Image.asset(imagePage.image8),
                ),
                SizedBox(
                  height: width * 0.03,
                ),
                Container(
                  height: width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "OTP has been sent to ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: colorPage.fortColor,
                                  ),
                                ),
                                Text(
                                  "*****634",
                                  style: TextStyle(
                                      color: colorPage.primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * 0.04),
                                ),
                                SvgPicture.asset(imagePage.image9),
                              ],
                            ),
                            Pinput(
                              controller: otp_controller,
                              length: 6,
                              defaultPinTheme: PinTheme(
                                  height: width * 0.18,
                                  width: width * 0.13,
                                  textStyle: TextStyle(
                                    color: colorPage.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: width * 0.08,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.02),
                                    border: Border.all(
                                        color: colorPage.primaryColor),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: width * 0.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                try{
                                  PhoneAuthCredential credential =await PhoneAuthProvider.credential(
                                      verificationId: widget.verificationid,
                                      smsCode: otp_controller.text.toString());
                                  FirebaseAuth.instance.signInWithCredential(credential).then((value){
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => homePage(),
                                        ));
                                  });
                                }catch(ex){
                                print(ex);
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
                                    borderRadius:
                                        BorderRadius.circular(width * 1)),
                                child: Center(
                                  child: Text("Verify",
                                      style: GoogleFonts.montserrat(
                                          color: colorPage.primaryColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: width * 0.045)),
                                ),
                              ),
                            ),
                            RichText(
                                text: TextSpan(
                                    text:
                                        "Haven't got the confirmation code yet? ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: colorPage.thirdColor,
                                    ),
                                    children: [
                                  TextSpan(
                                      text: "Resend",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: colorPage.primaryColor)),
                                ])),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        color: colorPage.secondaryColor,
        child: Center(
          child: RichText(
            text: TextSpan(
              text: "Try Another ",
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: colorPage.thirdColor),
              children: [
                TextSpan(
                    text: "Method?",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: colorPage.primaryColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
