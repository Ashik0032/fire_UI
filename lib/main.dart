import 'package:fire_ui/EditUser.dart';
import 'package:fire_ui/Profile.dart';
import 'package:fire_ui/add_User.dart';
import 'package:fire_ui/api%20task.dart';
import 'package:fire_ui/homePage.dart';
import 'package:fire_ui/login.dart';
import 'package:fire_ui/login_signup.dart';
import 'package:fire_ui/otp.dart';
import 'package:fire_ui/phone.dart';
import 'package:fire_ui/sharedPreference.dart';
import 'package:fire_ui/signup.dart';
import 'package:fire_ui/splash%20screen.dart';
import 'package:fire_ui/statefull&statless.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_integration.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(fireUI());
}
String? name;
var width;
var height;
class fireUI extends StatelessWidget {
  const fireUI({super.key});

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;

    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      // home:shared_preferences(),
      home:splash(),
    );
  }
}


