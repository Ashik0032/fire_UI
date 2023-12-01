import 'package:flutter/material.dart';

import 'main.dart';
int count=0;
class less extends StatelessWidget {
  const less({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    count++;

                  },
                  child: CircleAvatar(
                    radius: 30,

                  ),
                ),
                SizedBox(width: width*0.03,),
                Text(count.toString(),
                style: TextStyle(
                  fontSize: width*0.07,
                ),),
              ],
            ),

        ],
      ),
    );
  }
}


class full extends StatefulWidget {
  const full({super.key});

  @override
  State<full> createState() => _fullState();
}

class _fullState extends State<full> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  count++;
                  setState(() {

                  });

                },
                child: CircleAvatar(
                  radius: 30,

                ),
              ),
              SizedBox(width: width*0.03,),
              Text(count.toString(),
                style: TextStyle(
                  fontSize: width*0.07,
                ),),
            ],
          ),

        ],
      ),
    );
  }
}
