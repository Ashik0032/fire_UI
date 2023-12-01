import 'package:country_code_picker/country_code_picker.dart';
import 'package:fire_ui/color_page.dart';
import 'package:fire_ui/homePage.dart';
import 'package:fire_ui/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class shared_preferences extends StatefulWidget {
  const shared_preferences({super.key});

  @override
  State<shared_preferences> createState() => _shared_preferencesState();
}

class _shared_preferencesState extends State<shared_preferences> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController number_controller = TextEditingController();
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
    // getData();

    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPage.secondaryColor,
      body: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: Container(
          height: width * 2.25,
          width: width * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: number_controller,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.03),
                        borderSide: BorderSide())),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
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
                      size: width * 0.08, color: colorPage.sevenColor),
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
                      borderRadius: BorderRadius.circular(width * 0.03),
                      borderSide: BorderSide()),
                ),
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();

                  _prefs.setString('number', number_controller.text);
                  _prefs.setString('name', name_controller.text);
                  _prefs.setInt(
                      'num', int.tryParse(number_controller.text) ?? 0);

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Number & Name set Succesfully")));
                },
                child: Container(
                  height: width * 0.13,
                  width: width * 0.65,
                  decoration: BoxDecoration(
                      // color: colorPage.secondaryColor,
                      border: Border.all(
                          color: colorPage.primaryColor, width: width * 0.006),
                      borderRadius: BorderRadius.circular(width * 1)),
                  child: Center(
                    child: Text("set",
                        style: GoogleFonts.montserrat(
                            color: colorPage.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: width * 0.045)),
                  ),
                ),
              ),
              Text(num.toString(),
                  style: TextStyle(
                      fontSize: width * 0.08, fontWeight: FontWeight.w600)),
              Text(name,
                  style: TextStyle(
                      fontSize: width * 0.08, fontWeight: FontWeight.w600)),
              InkWell(
                onTap: () async {
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  number = _prefs.getString("number").toString();
                  name = _prefs.getString("name").toString();
                  num = _prefs.getInt('num')!;

                  setState(() {});
                },
                child: Container(
                  height: width * 0.13,
                  width: width * 0.65,
                  decoration: BoxDecoration(
                      // color: colorPage.secondaryColor,
                      border: Border.all(
                          color: colorPage.primaryColor, width: width * 0.006),
                      borderRadius: BorderRadius.circular(width * 1)),
                  child: Center(
                    child: Text("Get",
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
    );
  }
}
