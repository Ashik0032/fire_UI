import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class api_integration extends StatefulWidget {
  const api_integration({super.key});

  @override
  State<api_integration> createState() => _api_integrationState();
}

class _api_integrationState extends State<api_integration> {
  http.Response? apiData;

  getPostalData() async {
    print("object");
    apiData = await http.get(Uri.tryParse(
        "https://api.postalpincode.in/pincode/${number_controller.text}")!);
    print(apiData!.statusCode);

    api = json.decode(apiData!.body);

    if (apiData != null) {
      postOffice = api[0]['PostOffice'];

      if (postOffice.isNotEmpty) {
        setState(() {});
      }
    }

    setState(() {});
  }

  List api = [];
  List postOffice = [];
  TextEditingController number_controller = TextEditingController();

  @override
  void initState() {
    getPostalData();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: width * 0.25,
                    width: width * 0.7,
                    child: TextFormField(
                      onChanged: (value) {
                        getPostalData();
                      },
                      controller: number_controller,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.done,
                      maxLength: 6,
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width * 0.03),
                              borderSide: BorderSide())),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        getPostalData();
                        setState(() {});
                      },
                      child: Text("sear..")),
                ],
              ),
            ),
            // https://www.postpincode.in/api/getPostalArea.php?pincode=

            postOffice.isEmpty
                ? CircularProgressIndicator()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: postOffice.length,
                    itemBuilder: (context, index) {
                      print(postOffice[0]);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Name"),
                                Text(postOffice[index]["Name"].toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("BranchType"),
                                Text(
                                    postOffice[index]["BranchType"].toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("District"),
                                Text(postOffice[index]["District"].toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Division"),
                                Text(postOffice[index]["Division"].toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Region"),
                                Text(postOffice[index]["Region"].toString()),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }
}
