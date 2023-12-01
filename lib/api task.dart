import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class api_task extends StatefulWidget {
  const api_task({super.key});

  @override
  State<api_task> createState() => _api_taskState();
}

class _api_taskState extends State<api_task> {
  http.Response? apidata;
  // http.Response? apiData;/
  getUserData() async {
    apidata =
        await http.get(Uri.tryParse("https://reqres.in/api/users?page=1")!);

    // print("hello");

    user = json.decode(apidata!.body);
    page1 = user['data'];
    // print(page1);

    setState(() {});
  }

  var user;
  List page1 = [];

  @override
  void initState() {
    getUserData();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: page1.length,
            itemBuilder: (context, index) {
              return Container(
                width: width * 1,
                height: width * 0.23,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width*0.03),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      color: Colors.black.withOpacity(0.15)
                    )
                  ]
                ),

                margin: EdgeInsets.all(width * 0.05),
                child: Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(page1[index]["avatar"].toString()),
                      radius: width * 0.08,
                    ),
                    title: Text(
                        "Name : ${page1[index]['first_name'].toString()} ${page1[index]['last_name'].toString()}"),
                    subtitle:
                        Text("Email :${page1[index]["email"].toString()}"),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
