import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gain_muscle/screens/0_login/2_base_screen.dart';

import 'package:gain_muscle/tmp/controller.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DailyInputView extends StatefulWidget {
  const DailyInputView({Key? key, required this.today}) : super(key: key);

  final DateTime today;
  @override
  _DailyInputViewState createState() => _DailyInputViewState();
}

class _DailyInputViewState extends State<DailyInputView> {
  // key,value => 운동이름, [[무게1, 횟수1], [무게2, 횟수2] ...]
  Map<String, List<List<int>>> routine = {};
  // 유저가 선택한 운동 이름이 담겨있는 리스트
  List<dynamic> exercise = [];
  // 텍스트 필드를 다루기위해 만들어놓은 텍스트 필드의 리스트
  // 항목이 추가될때 추가되고, 제거될때 같이 제거된다
  List<dynamic> weight = [];
  List<dynamic> rep = [];

  String userName = FirebaseAuth.instance.currentUser!.displayName as String;
  CollectionReference userDB = FirebaseFirestore.instance.collection('user');

  Padding eachExercise(String exerciseName, int idx, int controllerIdx) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Row(
        children: [
          Text('${idx + 1}'),
          SizedBox(width: 30),
          Container(
            height: 30,
            width: 40,
            child: TextField(
              controller: weight[controllerIdx],
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (String w) {
                if (w.isNotEmpty) {
                  routine[exerciseName]![idx][0] = int.parse(w);
                }
              },
            ),
          ),
          Text('kg       '),
          Container(
            height: 30,
            width: 40,
            child: TextField(
              controller: rep[controllerIdx],
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (String r) {
                if (r.isNotEmpty) {
                  routine[exerciseName]![idx][1] = int.parse(r);
                }
              },
            ),
          ),
          Text('회'),
          IconButton(
            onPressed: () {
              routine[exerciseName]!.removeAt(idx);
              rep[controllerIdx].clear();
              weight[controllerIdx].clear();
              setState(() {});
            },
            icon: Icon(
              Icons.delete_outlined,
              color: Colors.red.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveRoutine() async {
    // 빈 입력인 경우 잡아주기

    // 오늘 날짜 구하기
    DateTime unixTimestamp = widget.today;
    String today = unixTimestamp.year.toString() +
        unixTimestamp.month.toString() +
        unixTimestamp.day.toString();
    var docSnapshot = userDB.doc(userName);
    var recordSnapshot = docSnapshot.collection('record');
    print("오늘의 기록이 잘 입력되었습니다");

    // data의 각 원소 = [운동이름, 세트수, [세트별 무게, 반복 횟수]]
    List<dynamic> data = [];
    // 하루의 총 운동 볼륨(무게 * 횟수)를 담는 변수
    int total = 0;
    for (String i in routine.keys) {
      // 현재 운동의 [무게, 반복 횟수] 가 세트별로 저장되는 배열
      List<dynamic> tmpData = [];
      for (int j = 0; j < routine[i]!.length; j++) {
        tmpData.add([routine[i]![j][0], routine[i]![j][1]]);
        total += routine[i]![j][0] * routine[i]![j][1];
      }
      data.add([i, routine[i]!.length, tmpData]);
    }

    recordSnapshot.doc(today).set({
      'data': jsonEncode(data),
      'date': today,
      'volume': total,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // List<dynamic> exercise = Get.find<Controller>().exerciseBasket;
    exercise = Get.find<Controller>().exerciseBasket;

    for (int i = 0; i < exercise.length; i++) {
      routine.addAll({
        exercise[i]: [
          // [0, 0]
        ]
      });
    }

    for (int i = 0; i < 50; i++) {
      rep.add(TextEditingController());
      weight.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    return GetBuilder<Controller>(builder: (_) {
      return GestureDetector(
        // onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Text(
                    widget.today.month.toString() +
                        "." +
                        widget.today.day.toString() +
                        '  운동계획',
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                ),

                // 운동별로 하나하나 카드로 보여주는 부분
                for (int i = 0; i < exercise.length; i++)
                  // eachExercise(exercise[i])
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Text(
                                  exercise[i],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                              IconButton(
                                onPressed: null,
                                icon: Icon(Icons.delete_outlined),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Container(
                              height: 30,
                              child: TextField(
                                  controller: null,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'memo',
                                  )),
                            ),
                          ),
                          for (int j = 0; j < routine[exercise[i]]!.length; j++)
                            // 지금 이부분이 텍스트 컨트롤러를 넣기위해서 만든 부분인데
                            eachExercise(exercise[i], j, i * 10 + j),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              routine[exercise[i]]!.isNotEmpty
                                  ? Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 10, 0),
                                      child: OutlinedButton.icon(
                                          onPressed: () {
                                            rep[i * 10 +
                                                    routine[exercise[i]]!
                                                        .length -
                                                    1]
                                                .clear();
                                            weight[i * 10 +
                                                    routine[exercise[i]]!
                                                        .length -
                                                    1]
                                                .clear();
                                            routine[exercise[i]]!.removeLast();
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.remove),
                                          label: Text(
                                            '세트제거',
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                    )
                                  : Container(),
                              // Spacer(),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: OutlinedButton.icon(
                                    onPressed: () {
                                      routine[exercise[i]]!.add([0, 0]);
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.add),
                                    label: Text(
                                      '세트추가',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                OutlinedButton(
                    onPressed: () {
                      print("루틴에 저장된 운동 출력!\n");
                      print(routine);
                      saveRoutine();
                      Get.offAll(BaseView());
                    },
                    child: Text(
                      '저장하기',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
      );
    });
  }
}
