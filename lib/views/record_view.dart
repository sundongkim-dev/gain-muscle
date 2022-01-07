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
  Record record =
      Record(uid: '', exercise: [''], time: ['']); // 밑에서 갱신해주므로 쓰레기값으로 만듬

  Future<Record> initialize() async {
    var documentSnapshot = await user.doc(uid).get();
    var data = documentSnapshot.data();
    String jsonStr = jsonEncode(data);
    Map<String, dynamic> rec2 = jsonDecode(jsonStr);
    Map<String, dynamic> rec3 = jsonDecode(rec2['record']);
    record = Record.fromJson(rec3);
    return record;
  }

  @override
  Widget build(BuildContext context) {
    Future<Record> futureRecord = initialize();

    return FutureBuilder(
      future: futureRecord,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print(record.exercise);
          print(record.time);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < record.time.length; i++)
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: record.exercise[i].length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return ListTile(
                            title: Text(record.time[i] + "의 운동"),
                          );
                        }
                        return ExerciseTile(
                            name: record.exercise[i][index - 1][0],
                            weight: record.exercise[i][index - 1][1],
                            rep: record.exercise[i][index - 1][2]);
                      },
                      separatorBuilder: (context, index) {
                        // if (index == 0) return SizedBox.shrink();
                        return Divider();
                      },
                    ),
                ],
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
