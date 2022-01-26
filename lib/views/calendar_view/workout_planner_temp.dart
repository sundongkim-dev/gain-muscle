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
  FocusNode _focusNode = FocusNode();
  // 이전 뷰(workout_meal_planner)로 부터 식단 기록할 날짜 받아 옴
  final DateTime _selectedDay = Get.arguments;

  final TextEditingController _textEditingController = TextEditingController();

  // // DB로 부터 가져온 운동 목록 사본
  // final List<Workout> _duplicatedWorkoutList =
  //     List<Workout>.generate(workoutList.length, (index) => workoutList[index]);
  // // 검색된(출력할) 운동 목록 저장
  // final List<Workout> _searchedWorkoutList = <Workout>[];
  // // 선택된 운동 목록 저장
  // // 1. 체크된 운동 개수
  // int _checkedWorkoutCounter = 0;
  // bool isButtonDisable = true;
  // // 2. CheckedWorkout 클래스의 isChecked 멤버 변수로 체크
  // final List<CheckedWorkout> _checkedWorkout = List<CheckedWorkout>.generate(
  //     workoutList.length,
  //     (index) => CheckedWorkout(
  //         workoutList[index].category, workoutList[index].name, false, Colors.white));
  // // ## 3. 체크된 운동을 또다른 List 변수에 에 저장 ##
  // final List<Workout> _checkedWorkoutList = <Workout>[];
  // // ## 하드코딩,, 버튼으로 검색하기
  // final List<String> _buttons = ['Chest', 'Shoulder', 'Back', 'Arm', 'Legs'];
  //
  // final bool _searchingState = false;

  // DB로 부터 가져온 운동 목록 사본 (Workout -> WorkoutForSearchAndSelect)
  final List<WorkoutForSearchAndSelect> _duplicatedWorkoutList =
      List<WorkoutForSearchAndSelect>.generate(
          workoutList.length,
          (index) => WorkoutForSearchAndSelect(workoutList[index].category,
              workoutList[index].name, false, Colors.white));

  // Expanded#1에 출력 - 검색된(출력할) 운동 목록 저장
  // 1. 검색된 운동 개수
  final List<WorkoutForSearchAndSelect> _searchedWorkoutList =
      <WorkoutForSearchAndSelect>[];

  // Expanded#2에 출력 - 선택된 운동 목록 저장
  // 1. 체크된 운동 개수
  int _selectedWorkoutCounter = 0;
  bool isButtonDisable = true;
  // 2. WorkoutForSearchAndSelect 클래스의 isSelected 멤버 변수로 체크
  final List<WorkoutForSearchAndSelect> _selectedWorkoutList =
      List<WorkoutForSearchAndSelect>.generate(
          workoutList.length,
          (index) => WorkoutForSearchAndSelect(workoutList[index].category,
              workoutList[index].name, false, Colors.white));
  // ## 3. 체크된 운동을 또다른 List 변수에 에 저장 ##
  // final List<WorkoutForSearchAndSelect> _selectedWorkoutList =
  //     <WorkoutForSearchAndSelect>[];
  // ## 하드코딩,, 버튼으로 검색하기
  final List<String> _buttons = ['Chest', 'Shoulder', 'Back', 'Arm', 'Legs'];
  // 텍스트로 검색시 그룹버튼 invisible
  final bool _searchingState = false;

  @override
  void initState() {
    super.initState();
    _searchedWorkoutList.addAll(_duplicatedWorkoutList);
  }

  // 운동 검색 결과를 '_searchedWorkoutList' 변수에 저장
  // void filterSearchResults(String query) {
  //   List<Workout> dummySearchList = List<Workout>.generate(
  //       _duplicatedWorkoutList.length,
  //       (index) => _duplicatedWorkoutList[index]);
  //
  //   if (query.isNotEmpty) {
  //     List<Workout> dummyListData = <Workout>[];
  //     dummySearchList.forEach((workout) {
  //       if (workout.contains(query)) {
  //         dummyListData.add(workout);
  //       }
  //     });
  //     setState(() {
  //       _searchedWorkoutList.clear();
  //       _searchedWorkoutList.addAll(dummyListData);
  //     });
  //   } else {
  //     setState(() {
  //       _searchedWorkoutList.clear();
  //       _searchedWorkoutList.addAll(_duplicatedWorkoutList);
  //     });
  //   }
  // }
  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<WorkoutForSearchAndSelect> dummySearchList =
          <WorkoutForSearchAndSelect>[];
      _duplicatedWorkoutList.forEach((workout) {
        if (workout.contains(query)) {
          dummySearchList.add(workout);
        }
      });
      setState(() {
        _searchedWorkoutList.clear();
        _searchedWorkoutList.addAll(dummySearchList);
      });
    } else {
      setState(() {
        _searchedWorkoutList.clear();
        _searchedWorkoutList.addAll(_duplicatedWorkoutList);
      });
    }
  }

  // 운동 체크 결과를 '_checkedWorkout' 변수에 반영, '_checkedWorkoutList' 변수에 저장
  // void filterSelectedResults(int index, bool isSelected) {
  //   setState(() {
  //     _checkedWorkout[index].isSelected = isSelected;
  //
  //     if (isSelected) {
  //       _checkedWorkoutCounter++;
  //       _checkedWorkoutList.add(_checkedWorkout[index]);
  //     } else if (_checkedWorkoutList.isNotEmpty) {
  //       _checkedWorkoutCounter--;
  //       _checkedWorkoutList.remove(_checkedWorkout[index]);
  //     }
  //
  //     if (_checkedWorkoutCounter == 0) {
  //       isButtonDisable = true;
  //     } else {
  //       isButtonDisable = false;
  //     }
  //   });
  // }
  void filterSelectedResults(int index) {
    setState(() {
      _selectedWorkoutList[index].isSelected =
          !_selectedWorkoutList[index].isSelected;

      if (_selectedWorkoutList[index].isSelected) {
        _selectedWorkoutCounter++;
        _selectedWorkoutList[index].color = Colors.blue;
        _selectedWorkoutList.add(_searchedWorkoutList[index]);

        _searchedWorkoutList[index].color = Colors.blue;
      } else if (_selectedWorkoutList.isNotEmpty) {
        _selectedWorkoutCounter--;
        _selectedWorkoutList[index].color = Colors.white;
        _selectedWorkoutList.remove(_searchedWorkoutList[index]);

        _searchedWorkoutList[index].color = Colors.white;
      }

      if (_selectedWorkoutCounter == 0) {
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
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 운동 검색창
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  focusNode: _focusNode,
                  controller: _textEditingController,
                  onChanged: (value) {
                    filterSearchResults(value);
                    print('changed');
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    hintText: '운동 검색',
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _textEditingController.clear();
                        filterSearchResults('');
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                  ),
                  onTap: () => print('clicked'),
                ),
                // 운동 그룹 검색 버튼 구현
                Visibility(
                  // visible: _searchingState,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GroupButton(
                      isRadio: false,
                      spacing: 3.0,
                      groupingType: GroupingType.row,
                      mainGroupAlignment: MainGroupAlignment.start,
                      buttons: _buttons,
                      onSelected: (index, isSelected) {
                        filterSearchResults(_buttons[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Expanded#1 - 검색된 운동 목록 출력
          Expanded(
            flex: 6,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchedWorkoutList.length,
              itemBuilder: (context, index) {
                // return CheckboxListTile(
                //   title: Row(
                //     children: [
                //       Padding(
                //         padding: EdgeInsets.all(4.0),
                //         child: Image.asset('assets/Img/userviewImg/strong.png'),
                //       ),
                //       Text(_searchedWorkoutList[index].toString()),
                //     ],
                //   ),
                //   value: _checkedWorkout[index].isChecked,
                //   onChanged: (bool? value) =>
                //       filterCheckedResults(index, value!),
                // );
                return Padding(
                  padding: EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
                  child: ListTile(
                    leading: Image.asset('assets/Img/userviewImg/strong.png'),
                    title: Text(_searchedWorkoutList[index].toString()),
                    tileColor: _searchedWorkoutList[index].color,
                    onTap: () {
                      filterSelectedResults(index);
                    },
                  ),
                );
              },
            ),
          ),
          Divider(
            thickness: 2.0,
            indent: 10.0,
            endIndent: 10.0,
          ),
          // Expanded#2 - 선택된 운동 목록 출력 (+삭제 버튼)
          Expanded(
            flex: 1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _selectedWorkoutList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(4.0),
                  child: _printSelectedWorkoutList(index),
                  // child: Row(
                  // children: [
                  // Text(_selectedWorkoutList[index].name),
                  // ## 미구현
                  // ElevatedButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       _checkedWorkoutList
                  //           .remove(_checkedWorkoutList[index]);
                  //     });
                  //   },
                  //   child: Icon(Icons.clear),
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.black,
                  //     shape: CircleBorder(),
                  //     fixedSize: const Size(1, 1),
                  //   ),
                  // ),
                  // ],
                  // ),
                );
              },
            ),
          ),
          // 체크된 운동 있을 때 버튼 활성화
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: _buildButton(),
          ),
        ],
      ),
    );
  }

  Widget _printSelectedWorkoutList(int index) {
    if (_selectedWorkoutList[index].isSelected) {
      print(_selectedWorkoutList[index].name + 'is selected');
      return Row(
        children: [
          Text(_selectedWorkoutList[index].name),
          ElevatedButton(
            onPressed: () {},
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

  Widget _buildButton() {
    return ElevatedButton(
      child: Text('운동 세부계획 입력하기'),
      onPressed: isButtonDisable
          ? null
          : () => Get.to(WorkoutDetailPlanner(), arguments: {
                'selectedDay': _selectedDay,
                'selectedWorkoutList': _selectedWorkoutList
              }),
    );
  }
}

class WorkoutForSearchAndSelect extends Workout {
  bool isSelected;
  Color color;

  WorkoutForSearchAndSelect(String category, String name,
      this.isSelected, this.color)
      : super(category, name);
}
