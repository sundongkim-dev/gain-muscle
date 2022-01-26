import 'package:flutter/material.dart';
import 'package:gain_muscle/src/controller.dart';
import 'package:get/get.dart';

class loadExerciseView extends StatefulWidget {
  const loadExerciseView({Key? key, required this.today}) : super(key: key);

  final DateTime today;
  @override
  _loadExerciseViewState createState() => _loadExerciseViewState();
}

class _loadExerciseViewState extends State<loadExerciseView> {
  List<String> weekday = [
    "패딩",
    "월요일",
    "화요일",
    "수요일",
    "목요일",
    "금요일",
    "토요일",
    "일요일"
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (_) {
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back)),
                      Text(
                        widget.today.month.toString() +
                            "월 " +
                            widget.today.day.toString() +
                            '일 ' +
                            weekday[widget.today.weekday],
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  )),
              Row(children: [
                Icon(Icons.calendar_today),
                Column(
                  children: [
                    Text('불러올 이전 계획을 선택해주세요!'),
                    Text('최근일 순으로 보여드립니다.')
                  ],
                )
              ]),
            ],
          ),
        ),
      );
    });
  }
}
