import 'dart:ffi';
import 'dart:ui';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:flutter/material.dart';
import 'package:gain_muscle/src/controller.dart';
import 'package:get/get.dart';

class DailyInputView extends StatefulWidget {
  const DailyInputView({Key? key, required this.today}) : super(key: key);

  final DateTime today;
  @override
  _DailyInputViewState createState() => _DailyInputViewState();
}

class _DailyInputViewState extends State<DailyInputView> {
  Map<String, List<List<int>>> routine = {};
  List<dynamic> exercise = [];
  List<dynamic> weight = [];
  List<dynamic> rep = [];
  int cnt = 0;

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
            ),
          ),
          Text('회'),
          IconButton(
            onPressed: () {
              routine[exerciseName]!.removeAt(idx);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // List<dynamic> exercise = Get.find<Controller>().exerciseBasket;
    exercise = Get.find<Controller>().exerciseBasket;

    for (int i = 0; i < exercise.length; i++) {
      routine.addAll({
        exercise[i]: [
          [0, 0]
        ]
      });
    }

    for (int i = 0; i < 50; i++) {
      rep.add(TextEditingController());
      weight.add(TextEditingController());
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   final controller = Get.put(Controller());
  //   return GetBuilder<Controller>(builder: (_) {
  //     return GestureDetector(
  //       // onTap: () => FocusScope.of(context).unfocus(),
  //       child: Material(
  //         child: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
  //                 child: Text(
  //                   widget.today.month.toString() +
  //                       "." +
  //                       widget.today.day.toString() +
  //                       '  운동계획',
  //                   style: TextStyle(color: Colors.black, fontSize: 30),
  //                 ),
  //               ),

  //               // 운동별로 하나하나 카드로 보여주는 부분
  //               for (int i = 0; i < exercise.length; i++)
  //                 // eachExercise(exercise[i])
  //                 Padding(
  //                   padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
  //                   child: Card(
  //                     child: Column(
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Padding(
  //                               padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
  //                               child: Text(
  //                                 exercise[i],
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 20),
  //                               ),
  //                             ),
  //                             IconButton(
  //                               onPressed: null,
  //                               icon: Icon(Icons.delete_outlined),
  //                             ),
  //                           ],
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
  //                           child: Container(
  //                             height: 30,
  //                             child: TextField(
  //                                 controller: null,
  //                                 decoration: InputDecoration(
  //                                   border: OutlineInputBorder(),
  //                                   labelText: 'memo',
  //                                 )),
  //                           ),
  //                         ),
  //                         for (int j = 0; j < routine[exercise[i]]!.length; j++)
  //                           eachExercise(exercise[i], j, i * 10 + j),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             routine[exercise[i]]!.isNotEmpty
  //                                 ? Padding(
  //                                     padding:
  //                                         EdgeInsets.fromLTRB(20, 0, 10, 0),
  //                                     child: OutlinedButton.icon(
  //                                         onPressed: () {
  //                                           routine[exercise[i]]!.removeLast();
  //                                           setState(() {});
  //                                         },
  //                                         icon: Icon(Icons.remove),
  //                                         label: Text(
  //                                           '세트제거',
  //                                           style:
  //                                               TextStyle(color: Colors.black),
  //                                         )),
  //                                   )
  //                                 : Container(),
  //                             // Spacer(),
  //                             Padding(
  //                               padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
  //                               child: OutlinedButton.icon(
  //                                   onPressed: () {
  //                                     print('세트추가하기');
  //                                     // print(
  //                                     //     '${weight[routine[exercise[i]]!.length - 1].text}를 ${rep[routine[exercise[i]]!.length - 1].text}만큼 들었음');
  //                                     print(
  //                                         '${weight[cnt].text}를 ${rep[cnt].text}만큼 들었음');
  //                                     // routine[exercise[i]]!.add([
  //                                     //   int.parse(weightController.text),
  //                                     //   int.parse(repController.text)
  //                                     // ]);
  //                                     if (routine[exercise[i]]!.isNotEmpty) {
  //                                       routine[exercise[i]]!
  //                                           .add(routine[exercise[i]]!.last);
  //                                     } else {
  //                                       routine[exercise[i]]!.add([0, 0]);
  //                                     }
  //                                     cnt++;
  //                                     setState(() {});
  //                                   },
  //                                   icon: Icon(Icons.add),
  //                                   label: Text(
  //                                     '세트추가',
  //                                     style: TextStyle(color: Colors.black),
  //                                   )),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   });
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
                                      print('세트추가하기');
                                      // print(
                                      //     '${weight[routine[exercise[i]]!.length - 1].text}를 ${rep[routine[exercise[i]]!.length - 1].text}만큼 들었음');
                                      print(
                                          '${weight[cnt].text}를 ${rep[cnt].text}만큼 들었음');
                                      // routine[exercise[i]]!.add([
                                      //   int.parse(weightController.text),
                                      //   int.parse(repController.text)
                                      // ]);
                                      if (routine[exercise[i]]!.isNotEmpty) {
                                        routine[exercise[i]]!
                                            .add(routine[exercise[i]]!.last);
                                      } else {
                                        routine[exercise[i]]!.add([0, 0]);
                                      }
                                      cnt++;
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
                    onPressed: null,
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
