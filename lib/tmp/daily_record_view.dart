import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gain_muscle/tmp/icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils.dart';

class DailyRecordView extends StatefulWidget {
  const DailyRecordView({Key? key}) : super(key: key);

  @override
  _DailyRecordViewState createState() => _DailyRecordViewState();
}

class _DailyRecordViewState extends State<DailyRecordView> {
  List<List<String>> dailyRecord = [];
  String name = "";
  String weight = "";
  String rep = "";

  var controllerName = TextEditingController();
  var controllerWeight = TextEditingController();
  var controllerRep = TextEditingController();

  String userName = FirebaseAuth.instance.currentUser!.displayName as String;
  CollectionReference userDB = FirebaseFirestore.instance.collection('user');

  void addRecord() {
    if (name == "" || weight == "" || rep == "") {
      return showToast("내용을 채워서 입력해주세요!");
    }
    List<String> tmpRecord = [name, weight, rep];

    controllerName.clear();
    controllerWeight.clear();
    controllerRep.clear();
    name = weight = rep = "";
    setState(() {
      // dailyRecord.add(tmpRecord);
      dailyRecord.insert(0, tmpRecord);
    });
  }

  void removeRecord() {
    if (dailyRecord.isEmpty) {
      return showToast("제거할 항목이 없습니다!");
    }
    setState(() {
      dailyRecord.removeAt(0);
    });
  }

  void showToast(String str) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> saveDate() async {
    // 빈 입력인 경우 잡아주기
    if (dailyRecord.isEmpty) {
      return showToast("기록을 입력하신 후 저장을 눌러주세요");
    }

    // 오늘 날짜 구하기
    var unixTimestamp = DateTime.now();
    String today = unixTimestamp.year.toString() +
        unixTimestamp.month.toString() +
        unixTimestamp.day.toString();

    var docSnapshot = userDB.doc(userName);
    var recordSnapshot = docSnapshot.collection('record');
    showToast("오늘의 기록이 잘 입력되었습니다");

    recordSnapshot.doc(today).set({
      'data': jsonEncode(dailyRecord),
      'date': today,
    });

    setState(() {
      dailyRecord.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff84ffff),
            title: Text(
              '오늘의 운동기록',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                // Spacer(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '오늘의 운동을 입력해주세요!',
                  style: TextStyle(fontSize: 28),
                ),
                Text('입력 예시를 알려드리겠습니다'),
                Text('운동이름 / 무게 / 반복횟수를 적어주세요'),
                Text('예) 스쿼트 80kg 50회'),

                Expanded(
                  child: ListView.separated(
                    itemCount: dailyRecord.isEmpty ? 1 : dailyRecord.length,
                    itemBuilder: (context, index) {
                      if (dailyRecord.isEmpty) {
                        return ListTile(
                          leading: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          title: Text('운동명 / 무게 / 반복횟수를 기록해주세요'),
                          subtitle: Text("무게와 횟수에는 숫자만 입력해주시면 됩니다"),
                        );
                      }
                      return ExerciseTile(
                          name: dailyRecord[index][0],
                          weight: dailyRecord[index][1],
                          rep: dailyRecord[index][2]);
                    },
                    separatorBuilder: (context, index) {
                      if (index == 0) return SizedBox.shrink();
                      return Divider();
                    },
                  ),
                ),

                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: controllerName,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.favorite),
                          labelText: "운동명",
                        ),
                        onChanged: (String str) {
                          name = str;
                        },
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: controllerWeight,
                        decoration: InputDecoration(
                          prefixIcon: Icon(MyFlutterApp.weight_hanging),
                          labelText: "무게(kg)",
                        ),
                        onChanged: (String str) {
                          weight = str;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: controllerRep,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.music_note),
                          labelText: "반복횟수",
                        ),
                        onChanged: (String str) {
                          rep = str;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        onPressed: addRecord,
                        icon: Icon(Icons.add),
                        label: Text('운동 추가')),
                    ElevatedButton.icon(
                        onPressed: removeRecord,
                        icon: Icon(Icons.remove),
                        label: Text('운동 제거')),
                    ElevatedButton.icon(
                        onPressed: saveDate,
                        icon: Icon(Icons.save),
                        label: Text('기록 저장')),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
