import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gain_muscle/src/icons.dart';
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

  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  void addRecord() {
    if (name == "" || weight == "" || rep == "") {
      return showToast("내용을 채워서 입력해주세요!");
    }
    List<String> tmpRecord = [name, weight, rep];

    controller1.clear();
    controller2.clear();
    controller3.clear();
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
    // 오늘 날짜 구하기
    var unixTimestamp = DateTime.now();
    String today = unixTimestamp.year.toString() +
        "/" +
        unixTimestamp.month.toString() +
        "/" +
        unixTimestamp.day.toString();

    var documentSnapshot = await user.doc(uid).get();
    // 현재 uid로 기록된 유저가 없는 경우
    if (documentSnapshot.data() == null) {
      Map<String, dynamic> newRecord =
          Record(uid: uid, exercise: [dailyRecord], time: [today]).toJson();
      String jsonRecord = jsonEncode(newRecord);
      return user
          .doc(uid)
          .set({'record': jsonRecord})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    // 기존 유저라서 기록을 업데이트 해줘야하는 경우 - DB가 익숙치 않아서 달아놓은 주석입니당
    // 1. 데이터를 불러온다
    var data = documentSnapshot.data();
    // 2. 불러온걸 json 형식으로 바꿔준다
    String jsonStr = jsonEncode(data);
    // 3. dart는 json을 Map으로 바꿔서 이해하므로 바꿔준다
    Map<String, dynamic> rec2 = jsonDecode(jsonStr);
    // 4. 각각의 항목도 json으로 되어있으므로 해석 풀어주기
    Map<String, dynamic> rec3 = jsonDecode(rec2['record']);
    // 5. 가져온거 이용해서 Record 객체 만들기
    Record realRecord = Record.fromJson(rec3);
    // 6. 방금의 기록을 새롭게 추가해주기
    realRecord.exercise.add(dailyRecord);
    realRecord.time.add(today);

    return user
        .doc(uid)
        .set({'record': jsonEncode(realRecord.toJson())})
        // .set({'uid': uid, 'record': jsonRec})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
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
                        controller: controller1,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.favorite),
                          labelText: "운동명",
                          // suffixIcon: IconButton(
                          //     icon: Icon(
                          //       Icons.clear,
                          //     ),
                          // onPressed: _TextController.clear
                          // hintText: "스쿼트",
                          // ),
                        ),
                        onChanged: (String str) {
                          name = str;
                        },
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: controller2,
                        decoration: InputDecoration(
                          prefixIcon: Icon(MyFlutterApp.weight_hanging),
                          labelText: "무게(kg)",
                          // suffixIcon: IconButton(
                          //     icon: Icon(Icons.clear),
                          //     onPressed: _TextController.clear),
                        ),
                        onChanged: (String str) {
                          weight = str;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: controller3,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.music_note),
                          labelText: "반복횟수",
                          // suffixIcon: IconButton(
                          //     icon: Icon(Icons.clear),
                          //     onPressed: _TextController.clear),
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
