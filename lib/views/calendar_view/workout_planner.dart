import 'package:flutter/material.dart';
import 'package:gain_muscle/src/app.dart';
import 'package:gain_muscle/views/calendar_view/workout_detail_planner.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';

import 'temp_workout_list.dart';

class WorkoutPlanner extends StatefulWidget {
  const WorkoutPlanner({Key? key}) : super(key: key);

  @override
  State<WorkoutPlanner> createState() => _WorkoutPlannerState();
}

class _WorkoutPlannerState extends State<WorkoutPlanner> {
  final TextEditingController _textEditingController = TextEditingController();

  final DateTime _selectedDay = Get.arguments;

  int _selectedWorkoutCounter = 0;
  final List<WorkoutForSearchAndSelect> _workoutList =
      List<WorkoutForSearchAndSelect>.generate(
          workoutList.length,
          (index) => WorkoutForSearchAndSelect(workoutList[index].category,
              workoutList[index].name, true, false, Colors.white));

  // 그룹버튼, 검색기능
  final List<String> _buttons = ['Chest', 'Shoulder', 'Back', 'Arm', 'Legs'];

  @override
  void initState() {
    super.initState();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      _workoutList.forEach((workout) {
        if (workout.contains(query)) {
          print('filter: ${workout.name}');
          setState(() {
            workout.isSearched = true;
          });
        } else {
          setState(() {
            workout.isSearched = false;
          });
        }
      });
    } else {
      // 검색어 없을 때
      setState(() {
        _workoutList.forEach((workout) {
          workout.isSearched = true;
        });
      });
    }
  }

  Widget _printSearchedWorkoutList(int index) {
    if (_workoutList[index].isSearched) {
      return Padding(
        padding: EdgeInsets.all(2.0),
        child: ListTile(
          leading: Image.asset('assets/Img/userviewImg/strong.png'),
          title: Text(_workoutList[index].toString()),
          tileColor: _workoutList[index].color,
          // 검색된 운동 목록 중 선택하기
          onTap: () {
            setState(() {
              _workoutList[index].isSelected = !_workoutList[index].isSelected;
              if (_workoutList[index].isSelected) {
                _workoutList[index].color = Colors.blue;
                _selectedWorkoutCounter++;
              } else {
                _workoutList[index].color = Colors.white;
                _selectedWorkoutCounter--;
              }
            });
          },
        ),
      );
    }
    return SizedBox.shrink();
  }

  bool _isVisible() {
    return (_selectedWorkoutCounter != 0) ? true : false;
  }

  Widget _printSelectedWorkoutList(int index) {
    if (_workoutList[index].isSelected) {
      return Row(
        children: [
          Text(_workoutList[index].name),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _workoutList[index].isSelected = false;
                _workoutList[index].color = Colors.white;
                _selectedWorkoutCounter--;
              });
            },
            child: Icon(Icons.clear),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
            ),
          ),
        ],
      );
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(DateFormat('MM월 dd일 운동 계획').format(_selectedDay)),
      ),
      body: Column(
        children: [
          // ==========================================
          // 검색 기능
          // ==========================================
          Container(
            color: Colors.blue[50],
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // 검색 텍스트 에디터
                  TextField(
                    controller: _textEditingController,
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  // 버튼 검색 (미구현)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GroupButton(
                      buttons: _buttons,
                      onSelected: (index, isSelected) {
                        filterSearchResults(_buttons[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // Expanded#1 - 검색된 운동 목록 출력
          // ==========================================
          Expanded(
            flex: 6,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _workoutList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: _printSearchedWorkoutList(index),
                );
              },
            ),
          ),
          Divider(
            thickness: 2.0,
            indent: 10,
            endIndent: 10,
          ),

          // ==========================================
          // Expanded#2 - 선택된 운동 목록 출력 (+삭제 기능)
          // ==========================================
          Visibility(
            visible: _isVisible(),
            child: Expanded(
              flex: 1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _workoutList.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.blue[50],
                    child: _printSelectedWorkoutList(index),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              child: Text('Button Test'),
              onPressed: () {},
              // onPressed: _isVisible()
              //     ? () => Get.to(
              //           WorkoutDetailPlanner(),
              //           arguments: {
              //             'selectedDay': _selectedDay,
              //             'workoutList': _workoutList,
              //           },
              //         )
              //     : null,
            ),
          ),
        ],
      ),
      // floatingActionButton: ElevatedButton(
      //   child: Text('Button Test'),
      //   onPressed: () {},
      // ),
    );
  }
}

class WorkoutForSearchAndSelect extends Workout {
  bool isSearched;
  bool isSelected;
  Color color;

  WorkoutForSearchAndSelect(String category, String name, this.isSearched,
      this.isSelected, this.color)
      : super(category, name);
}
