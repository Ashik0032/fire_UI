import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_ui/color_page.dart';
import 'package:fire_ui/image_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

class imagepicker extends StatefulWidget {
  const imagepicker({super.key});

  @override
  State<imagepicker> createState() => _imagepickerState();
}

class _imagepickerState extends State<imagepicker> {

  String imageurl ='';

  File? file;
  pickFile(ImageSource) async {
    final imageFile = await ImagePicker.platform.pickImage(source: ImageSource);
    file = File(imageFile!.path);
    if (mounted) {
      setState(()  {
        file = File(imageFile.path);
      });
    }
  }

  uploadFile() async {
    if(file!=null) {
      var uploadTask = await FirebaseStorage.instance.ref("images").child(
          '${DateTime.now()}').putFile(file!);

      imageurl = await uploadTask.ref.getDownloadURL();


      print(imageurl);
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          file != null
              ? Center(
                  child: Container(
                    height: width * 0.6,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(file!), fit: BoxFit.cover)),
                  ),
                )
              : Center(
                child: Container(
                  height: width * 0.6,
                  width: width * 0.8,
                  child: Image.asset(imagePage.image16),
                  // backgroundColor: colorPage.primaryColor,
                ),
              ),
          ElevatedButton(onPressed: () {
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
          }, child: Text("add")),

          ElevatedButton(onPressed: () {
            uploadFile();
          }, child: Text("Upload")),

          imageurl!="" ? Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(imageurl))
            ),
          ) : SizedBox(),
        ],
      ),
    );
  }
}
