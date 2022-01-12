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
  CollectionReference user = FirebaseFirestore.instance.collection('user');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Record record =
      Record(uid: '', exercise: [''], time: ['']); // 밑에서 갱신해주므로 쓰레기값으로 만듬

  Future<Record> initialize() async {
    // 아직 유저기록이 없을때도 핸들링해줘야함. 이거 생각해보기!
    var documentSnapshot = await user.doc(uid).get();
    var data = documentSnapshot.data();

    // 기록이 없을때 구분해주기
    if (data == null) {
      return record;
    }

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
          if (record.uid == '') {
            // return Container(color: Colors.redAccent);
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('입력된 기록이 없습니다. 기록을 입력해주세요'),
                ElevatedButton(
                    onPressed: () => Get.to(() => DailyRecordView()),
                    child: Text('기록 입력하러 이동하기')),
              ],
            )
                // Text('아직 운동기록을 입력해주지 않으셨습니다'),

                );
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = record.time.length - 1; i >= 0; i--)
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
