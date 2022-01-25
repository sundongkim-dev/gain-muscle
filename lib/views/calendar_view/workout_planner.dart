import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';

import 'temp_workout_list.dart';
import 'workout_detail_planner.dart';

class WorkoutPlanner extends StatefulWidget {
  const WorkoutPlanner({Key? key}) : super(key: key);

  @override
  State<WorkoutPlanner> createState() => _WorkoutPlannerState();
}

class _WorkoutPlannerState extends State<WorkoutPlanner> {
  // 이전 뷰(workout_meal_planner)로 부터 식단 기록할 날짜 받아 옴
  final DateTime _selectedDay = Get.arguments;

  final TextEditingController _textEditingController = TextEditingController();

  // DB로 부터 가져온 운동 목록 사본
  final List<Workout> _duplicatedWorkoutList =
      List<Workout>.generate(workoutList.length, (index) => workoutList[index]);
  // 검색된(출력할) 운동 목록 저장
  final List<Workout> _searchedWorkoutList = <Workout>[];
  // 선택된 운동 목록 저장
  // 1. 체크된 운동 개수
  int _checkedWorkoutCounter = 0;
  bool isButtonDisable = true;
  // 2. CheckedWorkout 클래스의 isChecked 멤버 변수로 체크
  final List<CheckedWorkout> _checkedWorkout = List<CheckedWorkout>.generate(
      workoutList.length,
      (index) => CheckedWorkout(
          workoutList[index].category, workoutList[index].name, false));
  // ## 3. 체크된 운동을 또다른 List 변수에 에 저장 ##
  final List<Workout> _checkedWorkoutList = <Workout>[];
  // ## 하드코딩,, 버튼으로 검색하기
  final List<String> _buttons = ['Chest', 'Shoulder', 'Back', 'Arm', 'Legs'];

  final bool _searchingState = false;

  @override
  void initState() {
    super.initState();
    _searchedWorkoutList.addAll(_duplicatedWorkoutList);
  }

  // 운동 검색 결과를 '_searchedWorkoutList' 변수에 저장
  void filterSearchResults(String query) {
    List<Workout> dummySearchList = List<Workout>.generate(
        _duplicatedWorkoutList.length,
        (index) => _duplicatedWorkoutList[index]);

    if (query.isNotEmpty) {
      List<Workout> dummyListData = <Workout>[];
      dummySearchList.forEach((workout) {
        if (workout.contains(query)) {
          dummyListData.add(workout);
        }
      });
      setState(() {
        _searchedWorkoutList.clear();
        _searchedWorkoutList.addAll(dummyListData);
      });
    } else {
      setState(() {
        _searchedWorkoutList.clear();
        _searchedWorkoutList.addAll(_duplicatedWorkoutList);
      });
    }
  }

  // 운동 체크 결과를 '_checkedWorkout' 변수에 반영, '_checkedWorkoutList' 변수에 저장
  void filterCheckedResults(int index, bool isChecked) {
    setState(() {
      _checkedWorkout[index].isChecked = isChecked;

      if (isChecked) {
        _checkedWorkoutCounter++;
        _checkedWorkoutList.add(_checkedWorkout[index]);
      } else if (_checkedWorkoutList.isNotEmpty) {
        _checkedWorkoutCounter--;
        _checkedWorkoutList.remove(_checkedWorkout[index]);
      }

      if (_checkedWorkoutCounter == 0) {
        isButtonDisable = true;
      } else {
        isButtonDisable = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('MM월 dd일 운동 계획').format(_selectedDay)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 운동 검색창
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _textEditingController,
                    onChanged: (value) => filterSearchResults(value),
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: '운동 검색',
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  // 운동 그룹 검색 버튼 구현
                  Visibility(
                    visible: _searchingState,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GroupButton(
                        isRadio: false,
                        spacing: 3.0,
                        groupingType: GroupingType.row,
                        mainGroupAlignment: MainGroupAlignment.start,
                        // direction: Axis.horizontal,
                        buttons: _buttons,
                        onSelected: (index, isSelected) {
                          filterSearchResults(_buttons[index]);
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 운동 목록 출력
          Expanded(
            // ## 검색창 텍스트 입력할 때 픽셀 부족,,
            flex: 5,
            child: SingleChildScrollView(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                // ##이거 뭐지 (있어야 함)
                shrinkWrap: true,
                itemCount: _searchedWorkoutList.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Row(
                      children: [
                        Icon(Icons.image),
                        Text(_searchedWorkoutList[index].toString()),
                      ],
                    ),
                    value: _checkedWorkout[index].isChecked,
                    onChanged: (bool? value) =>
                        filterCheckedResults(index, value!),
                  );
                },
              ),
            ),
          ),
          Divider(
            thickness: 2.0,
            indent: 10.0,
            endIndent: 10.0,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dummy'),
                // 선택한 운동 목록 출력 및 삭제 기능 구현
                // SingleChildScrollView(
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     physics: ClampingScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: 5,
                //     itemBuilder: (context, index) {
                //       return Text('test');
                //     },
                //   ),
                // ),
                // 운동 세부계획 설정 뷰 이동
                // ElevatedButton(
                //   child: Text('운동 세부계획 입력하기'),
                //   onPressed: () => Get.to(WorkoutDetailPlanner(),
                //       arguments: _checkedWorkout),
                // ),
                // 운동이 체크되면 버튼 활성화
                _buildButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      child: Text('운동 세부계획 입력하기'),
      onPressed: isButtonDisable
          ? null
          : () => Get.to(WorkoutDetailPlanner(), arguments: {
                'selectedDay': _selectedDay,
                'checkedWorkoutList': _checkedWorkoutList
              }),
    );
  }
}

class CheckedWorkout extends Workout {
  bool isChecked;

  CheckedWorkout(String category, String name, this.isChecked)
      : super(category, name);

  @override
  String toString() {
    return super.toString() + '($isChecked)';
  }
}
