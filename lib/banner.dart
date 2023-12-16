import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fire_ui/color_page.dart';
import 'package:fire_ui/image_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Profile.dart';
import 'login.dart';
import 'main.dart';

class Banner_page extends StatefulWidget {
  const Banner_page({super.key});

  @override
  State<Banner_page> createState() => _Banner_pageState();
}

class _Banner_pageState extends State<Banner_page> {
  int selectIndex=0;

  int selectedOption = 0;
  int tap = 0;

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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colorPage.secondaryColor,
          elevation: 0,
          title: Text("Hello",
              style: TextStyle(
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.w500,
                  color: colorPage.thirdColor)),
          actions: [
            CircleAvatar(
              radius: width * 0.06,
              backgroundColor: colorPage.primaryColor,
              backgroundImage: AssetImage(imagePage.image15),
            ),
            SizedBox(width: width*0.04,)

          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(width * 0.05),
            child: Container(
                height: width * 2.25,
                width: width * 1,

              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: 3,
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        selectIndex = index;
                        setState(() {});
                      },
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(
                        milliseconds: 20,
                      ),
                      viewportFraction: 1,
                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return Container(
                          height: width * 0.5,
                          width: width * 1,
                          margin: EdgeInsets.only(right: width * 0.03),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.03),
                              color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage(imagePage.image17),
                                  fit: BoxFit.fill),

                          ));
                    },
                  ),
                  SizedBox(height: width * 0.03),
                  AnimatedSmoothIndicator(
                    activeIndex: selectIndex,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.black,
                      dotColor: Colors.indigo,
                      dotHeight: width * 0.03,
                      dotWidth: width * 0.03,
                    ),
                  ),

                  SizedBox(height: width*0.05,),
                  InkWell(
                    onTap: () {
                      
                    },
                    child: Container(
                      height: width*0.13,
                      width: width*0.3,

                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(width*1),
                      ),
                    ),
                  ),
                  SizedBox(height: width*0.05,),
                  Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.025,
                        left: width * 0.025,
                        bottom: width * 0.025,
                        top: width * 0.01),
                    child: InkWell(
                      onTap: () {
                        pickFile(ImageSource.gallery);
                      },
                      child: file!=null?
                      Container(
                        height: width * 0.52,
                        width: width * 0.9,

                        child: Image.file(file,fit: BoxFit.cover),
                        decoration: BoxDecoration(
                            color: colorPage.secondaryColor,
                          borderRadius: BorderRadius.circular(width*0.03)
                        ),
                      ):
                      Container(
                        height: width * 0.52,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.03),
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Container(
                            height: width * 0.3,
                            width: width * 0.9,
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: width * 0.2,
                                    width: width * 0.2,
                                    child:
                                    Image.asset(imagePage.image11),
                                  ),
                                  Text(
                                      "Upload image",
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: width * 0.045,
                                            color: Colors.black),
                                      )
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            )));
  }
}
