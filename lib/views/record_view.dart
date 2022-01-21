import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils.dart';
import 'daily_record_view.dart';

class RecordView extends StatefulWidget {
  const RecordView({Key? key}) : super(key: key);

  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  String userName = FirebaseAuth.instance.currentUser!.displayName as String;
  List<List<dynamic>> record = [];
  List<String> date = [];

  Future<void> getData() async {
    CollectionReference recordDB =
        FirebaseFirestore.instance.collection('user/$userName/record');
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await recordDB.get();

    // Get data from docs and convert map to List
    List<Object?> tmpRecord =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    for (int i = 0; i < tmpRecord.length; i++) {
      Map<String, dynamic> tmp = tmpRecord[i] as Map<String, dynamic>;
      record.add(jsonDecode(tmp['data']));
      date.add(tmp['date']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 입력된 기록이 없을때
            if (record.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('입력된 기록이 없습니다. 기록을 입력해주세요'),
                    ElevatedButton(
                        onPressed: () => Get.to(() => DailyRecordView()),
                        child: Text('기록 입력하러 이동하기')),
                  ],
                ),
              );
            }
            // 기록 있을때
            else {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = record.length - 1; i >= 0; i--)
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: record[i].length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return ListTile(
                                title: Text(date[i] + '의 운동'),
                              );
                            }
                            return ExerciseTile(
                                name: record[i][index - 1][0],
                                weight: record[i][index - 1][1],
                                rep: record[i][index - 1][2]);
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
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
