import 'package:country_code_picker/country_code_picker.dart';
import 'package:fire_ui/color_page.dart';
import 'package:fire_ui/image_page.dart';
import 'package:fire_ui/login.dart';
import 'package:fire_ui/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

class phone extends StatefulWidget {
  const phone({super.key});

  @override
  State<phone> createState() => _phoneState();
}

class _phoneState extends State<phone> {
  TextEditingController number_controller = TextEditingController();
  final numbervallidation = RegExp(r'[0-9]{10}');
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
          padding:  EdgeInsets.all(width*0.02),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: width*0.03,
                width: width*0.03,
                child: SvgPicture.asset(imagePage.image6)),
          ),
        ),
        title: Text("Enter Phone Number",
            style: TextStyle(
              fontSize:width*0.055 ,
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
                  height: width*1.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: width*0.87,
                        height: width*0.7,
                        // color: Colors.red,
                        child: Image.asset(imagePage.image7),
                      ),
                      SizedBox(height: width*0.03,),
                      TextFormField(
                        controller: number_controller,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textInputAction: TextInputAction.done,
                        maxLength: 10,
                        style: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w600,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (!numbervallidation.hasMatch(value!)) {
                            return "enter valid number";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: CountryCodePicker(
                            onChanged: print,
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'In',
                            favorite: ['+91','in'],
                            // optional. Shows only country name and flag
                            showCountryOnly: false,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                          ),
                          labelText: "Contact number",
                          labelStyle: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w400,
                              color: colorPage.primaryColor),
                          hintText: "Enter your number",
                          hintStyle: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w600,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(width * 0.025),
                              borderSide: BorderSide(
                                color: colorPage.primaryColor,
                              )),
                          // focusedBorder: OutlineInputBorder(
                          //     borderRadius:
                          //         BorderRadius.circular(width * 0.025),
                          //     borderSide: BorderSide(
                          //       color: colorPage.primaryColor,
                          //     ))
                        ),
                      ),
                      SizedBox(height: width*0.03,),
                      InkWell(
                        onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => otp(),));
                        },
                        child: Container(
                          height: width*0.13,
                          width: width*0.65,
                          decoration: BoxDecoration(
                            // color: colorPage.secondaryColor,
                              border: Border.all(color: colorPage.primaryColor,
                                  width: width*0.006 ),
                              borderRadius: BorderRadius.circular(width * 1)),
                          child: Center(
                            child: Text("Send OTP",
                                style: GoogleFonts.montserrat(
                                    color: colorPage.primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: width*0.045
                                )
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: width*0.03,),

                    ],
                  ),
                ),


                // RichText(
                //   text: TextSpan(
                //     text: "Don’t have an account ? ",
                //     style: TextStyle(
                //         fontWeight: FontWeight.w500,
                //         color: colorPage.primaryColor),
                //     children: [
                //       TextSpan(
                //           text: "Create Now",
                //           style: TextStyle(
                //               fontWeight: FontWeight.w600,
                //               color: colorPage.primaryColor)),
                //     ],
                //   ),
                // ),

              ],
            ),
          ),
        ),
      ),
      bottomSheet:
      Container(
        height: 60,
        color: colorPage.secondaryColor,


        child: Center(
          child: RichText(
            text: TextSpan(
              text: "Sign in with ",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: colorPage.thirdColor),
              children: [
                TextSpan(
                    text: " Another Method ?",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: colorPage.primaryColor)),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
