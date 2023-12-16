import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_ui/EditUser.dart';
import 'package:fire_ui/image_page.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class newPage extends StatefulWidget {
  const newPage({super.key, required this.id});
  final String id;
  @override
  State<newPage> createState() => _newPageState();
}

class _newPageState extends State<newPage> {
  var data1;
  getData() async {
    var data = await FirebaseFirestore.instance
        .collection("flit")
        .doc(widget.id)
        .get();
    data1 = data.data();

    setState(() {});
  }

  @override
  void initState() {

    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("flit").doc(widget.id).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var data = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: width * 0.15,
                      backgroundImage: AssetImage(imagePage.image11),
                    ),
                    Text(
                      data!["name"],
                      style: TextStyle(fontSize: width * 0.07),
                    ),
                    Text(
                      data!["email"],
                      style: TextStyle(fontSize: width * 0.07),
                    ),
                    Text(
                      data!.id,
                      style: TextStyle(fontSize: width * 0.05),
                    ),
                Text(
                data!["password"],
                style: TextStyle(fontSize: width * 0.07),
                ),
                  ],
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  getData();
                },
                child: Text("Get data")),
            data1 == null
                ? Text('no data')
                : Column(
                    children: [
                      Text(data1['name'].toString()),
                      Text(data1['email'].toString()),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
