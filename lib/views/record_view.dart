import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class recordView extends StatefulWidget {
  const recordView({Key? key}) : super(key: key);

  @override
  _recordViewState createState() => _recordViewState();
}

class _recordViewState extends State<recordView> {
  CollectionReference user = FirebaseFirestore.instance.collection('user');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  var documentSnapshot;
  var data;
  late Record userRecord;
  // documentSnapshot = await user.doc(uid).get();
  // data = documentSnapshot.data();
  // // String jsonStr = jsonEncode(data);
  // // Map<String, dynamic> rec2 = jsonDecode(jsonStr);
  // // Map<String, dynamic> rec3 = jsonDecode(rec2['record']);
  // // userRecord = Record.fromJson(rec3);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  void initialize() async {
    documentSnapshot = await user.doc(uid).get();
    data = documentSnapshot.data();
    String jsonStr = jsonEncode(data);
    Map<String, dynamic> rec2 = jsonDecode(jsonStr);
    Map<String, dynamic> rec3 = jsonDecode(rec2['record']);
    userRecord = Record.fromJson(rec3);
    print(userRecord.exercise);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '운동기록',
          style: TextStyle(fontSize: 20),
        ),
      ],
    ));
  }
}
