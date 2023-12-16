// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DatabaseMethods{
//   Future addUser(String userId, Map<String, dynamic>  userInfoMap){
//     return FirebaseFirestore.instance.collection("flit").doc(userId).set(userInfoMap);
//   }
// }
// import 'package:flutter/material.dart';
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new MyHomePage(title: 'Hero Animation Example', key: Key(AutofillHints.countryName),),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({required Key key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text(widget.title),
//       ),
//       body: Hero(
//           tag: 'flutterLogo',
//           child: GestureDetector(
//               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HeroExamplePage())),
//               child: FlutterLogo(
//                 size: 100.0,
//               ))),
//     );
//   }
// }
//
// class HeroExamplePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Selected image'),
//       ),
//       body: Center(
//         child: Hero(
//             tag: 'flutterLogo',
//             child: FlutterLogo(
//               size: 200.0,
//             )
//         ),
//       ),
//     );
//   }
// }