import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_ui/EditUser.dart';
import 'package:fire_ui/Profile.dart';
import 'package:fire_ui/add_User.dart';
import 'package:fire_ui/color_page.dart';
import 'package:fire_ui/google_database.dart';
import 'package:fire_ui/image_page.dart';
import 'package:fire_ui/login_signup.dart';
import 'package:fire_ui/newPage.dart';
import 'package:fire_ui/sharedPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'main.dart';
import 'main.dart';
import 'main.dart';
import 'main.dart';
import 'main.dart';
import 'main.dart';
import 'main.dart';
import 'main.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String number = '';
  // String name = '';
  int num = 0;
  bool tap = true;
  // bool login = false;
  // getData() async {
  //   SharedPreferences _prefs =
  //   await SharedPreferences.getInstance();
  //   // login = _prefs.getBool('login')!;
  //
  // }
  @override
  void initState() {
    // getData();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:

        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              backgroundColor: colorPage.primaryColor,
              onPressed: () {
                Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => add_User(),
                            ));
              },
              label: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.image,color: Colors.white,),
                  ),
                  Text("Add Banner"),
                ],
              ),
              // child: Icon(Icons.add,color: Colors.white,),
            ),
            SizedBox(height: 30,),
            FloatingActionButton.extended(
              backgroundColor: colorPage.primaryColor,
              onPressed: () {
                Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => add_User(),
                            ));
              },
              label: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(CupertinoIcons.person,color: Colors.white,),
                  ),
                  Text("Add User"),
                ],
              ),
              // child: Icon(Icons.add,color: Colors.white,),
            ),
          ],
        ),
        // InkWell(
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         CupertinoPageRoute(
        //           builder: (context) => add_User(),
        //         ));
        //   },
        //   child: CircleAvatar(
        //     radius: width * 0.08,
        //     child:
        //         Icon(Icons.add, size: width * 0.07, color: colorPage.nineColor),
        //     backgroundColor: colorPage.primaryColor,
        //   ),
        // ),
        backgroundColor: colorPage.secondaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colorPage.secondaryColor,
          elevation: 0,
          title: Text("Hello, $currentUserName",
              style: TextStyle(
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.w500,
                  color: colorPage.thirdColor)),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => profile(
                        name1: currentUserName.toString(),
                        email: currentUserEmail.toString(),
                        password: currentUserPassword.toString(),
                      ),
                    ));
              },
              child: CircleAvatar(
                radius: width * 0.06,
                backgroundColor: colorPage.primaryColor,
                backgroundImage: AssetImage(imagePage.image15),
              ),
            ),
            SizedBox(
              width: width * 0.06,
            ),
            IconButton(
                onPressed: () async {
                  // SharedPreferences  name=await SharedPreferences.getInstance() ;
                  // name.remove('login');
                  GoogleSignIn().signOut();
                  SharedPreferences name =
                      await SharedPreferences.getInstance();

                  name.remove("name");
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => login_signup(),
                      ));
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(width * 0.05),
            child: Container(
                height: width * 2.25,
                width: width * 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Users",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: colorPage.thirdColor),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('flit')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }

                            var data = snapshot.data!.docs;

                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              newPage(id: data[index].id),
                                        ));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(bottom: width * 0.035),
                                    height: width * 0.23,
                                    width: width * 1,
                                    decoration: BoxDecoration(
                                        color: colorPage.eightColor,
                                        borderRadius: BorderRadius.circular(
                                            width * 0.02)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                            radius: width * 0.08,
                                            backgroundColor: colorPage
                                                .secondaryColor
                                                .withOpacity(0.50),
                                            backgroundImage: NetworkImage(
                                                data[index]["images"])),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data[index]["name"],
                                              style: GoogleFonts.roboto(
                                                  fontSize: width * 0.04,
                                                  fontWeight: FontWeight.w700,
                                                  color: colorPage.thirdColor),
                                            ),
                                            Text(
                                              data[index]['email'],
                                              style: GoogleFonts.roboto(
                                                  fontSize: width * 0.033,
                                                  fontWeight: FontWeight.w300,
                                                  color: colorPage.thirdColor),
                                            ),
                                            Text(
                                              data[index]["password"],
                                              style: GoogleFonts.roboto(
                                                  fontSize: width * 0.033,
                                                  fontWeight: FontWeight.w300,
                                                  color: colorPage.thirdColor),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showCupertinoModalPopup(
                                              barrierColor: colorPage.sixColor,
                                              context: context,
                                              builder: (context) {
                                                return CupertinoAlertDialog(
                                                  content: Text(
                                                      "Are you Sure\nYou Want to delete User ?",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              width * 0.045)),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      isDestructiveAction: true,
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('flit')
                                                            .doc(data[index].id)
                                                            .delete();
                                                        // FirebaseFirestore.instance.collection('flit').doc(widget.id).update();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Yes"),
                                                    ),
                                                    CupertinoDialogAction(
                                                      isDefaultAction: true,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Cancel"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                              height: width * 0.07,
                                              width: width * 0.07,
                                              child: SvgPicture.asset(
                                                  imagePage.image12)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      editUser(
                                                    name1: data[index]['name'],
                                                    email: data[index]['email'],
                                                    password: data[index]
                                                        ['password'],
                                                    id: data[index].id,
                                                    image: data[index]
                                                        ['images'],
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                              height: width * 0.07,
                                              width: width * 0.07,
                                              child: SvgPicture.asset(
                                                  imagePage.image9)),
                                        )
                                        // SvgPicture.asset(imagePage.image11),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                    )
                  ],
                ))));
  }
}
