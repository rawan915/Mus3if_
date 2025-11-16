// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class CloudMessages extends StatefulWidget {
//   const CloudMessages({super.key});

//   @override
//   State<CloudMessages> createState() => _CloudMessagesState();
// }

// class _CloudMessagesState extends State<CloudMessages> {
//   Future<void> getToken() async {
//     String? myToken = await FirebaseMessaging.instance.getToken();
//     debugPrint('=============================');
//     debugPrint(myToken);
//     debugPrint('=============================');
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getToken(); 
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }
