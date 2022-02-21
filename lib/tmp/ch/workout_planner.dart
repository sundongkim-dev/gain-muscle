import 'package:flutter/material.dart';
import 'package:gain_muscle/tmp/ch/workout_detail_planner.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import '../../tmp/ch/temp_workout_list.dart';

// import 'package:gain_muscle/views/calendar_view/workout_detail_planner.dart';
// import 'package:gain_muscle/src/app.dart';
class WorkoutPlanner extends StatefulWidget {
  const WorkoutPlanner({Key? key}) : super(key: key);

  @override
  State<WorkoutPlanner> createState() => _WorkoutPlannerState();
}

class _WorkoutPlannerState extends State<WorkoutPlanner> {
  final FocusNode _focusNode = FocusNode();

  // 선택된 날짜
  final DateTime _selectedDay = Get.arguments;
  final TextEditingController _textEditingController = TextEditingController();

  // 그룹버튼/ 컨트롤러
  final GroupButtonController _groupButtonController = GroupButtonController();
  // 그룹버튼/ 텍스트필드 포커스일 때 invisible
  bool _isGroupButtonVisible = true;
  // 그룹버튼/ 검색기능
  final List<String> _buttons = ['Chest', 'Shoulder', 'Back', 'Arm', 'Legs'];

  int _selectedWorkoutCounter = 0;
  final List<WorkoutForSearchAndSelect> _workoutList =
      List<WorkoutForSearchAndSelect>.generate(
          workoutList.length,
          (index) => WorkoutForSearchAndSelect(workoutList[index].category,
              workoutList[index].name, true, false, Colors.white, false));

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _textEditingController.dispose();
    _groupButtonController.dispose();
  }

  // ===========================================
  // #1 검색기능
  // 운동 이름이 검색어를 포함하는지에 따라
  // Workout.isSearched 값 변경
  // ==========================================
  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      for (var workout in _workoutList) {
        if (workout.contains(query)) {
          setState(() {
            workout.isSearched = true;
          });
        } else {
          setState(() {
            workout.isSearched = false;
          });
        }
      }
    } else {
      // 검색어 없을 때
      setState(() {
        for (var workout in _workoutList) {
          workout.isSearched = true;
        }
      });
    }
  }

  // ===========================================
  // #1 그룹버튼 검색 비활성화
  // 텍스트필드를 이용해 검색할 때 그룹 버튼 비활성화
  // 텍스트필드 포커스 해제될 때 그룹 버튼 초기화
  // ** 텍스트 입력 안하고 텍스트필드 X버튼(전체 포커스 해제) 눌러도 초기화 되는데 버튼은 안사라짐
  // ==========================================
  void _onFocusChanged() {
    setState(() {
      _focusNode.hasFocus
          ? _isGroupButtonVisible = false
          : _isGroupButtonVisible = true;

      if (_isGroupButtonVisible) {
        _groupButtonController.unselectAll();
      }
    });
  }

  // ==========================================
  // #2 검색된 운동 목록 출력
  // (Workout.isSearched == true) 출력
  // ------------------------------------------
  // #3 운동 목록 중 계획에 포함할 운동 선택
  // Workout.isSelected 값 변경
  // _selectedWorkoutCounter 조정 (0일 때 버튼 비활성화)
  // ==========================================
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
                _workoutList[index].color = Colors.lightBlue.shade50;
                _selectedWorkoutCounter++;
              } else {
                _workoutList[index].color = Colors.white;
                _selectedWorkoutCounter--;
              }
            });
          },
          trailing: IconButton(
            icon: _workoutList[index].isFavorite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            color: _workoutList[index].isFavorite ? Colors.red : null,
            onPressed: () {
              setState(() {
                _workoutList[index].isFavorite =
                    !_workoutList[index].isFavorite;
              });
            },
          ),
        ),
      );
    }
    return SizedBox.shrink();
  }

  // ==========================================
  // #3 선택된 운동 없을 때 장바구니 안보임
  // ------------------------------------------
  // #4 선택된 운동 없을 때 버튼 비활성화
  // ==========================================
  bool _isVisible() {
    return (_selectedWorkoutCounter != 0) ? true : false;
  }

  // ==========================================
  // #3 선택된 운동 장바구니
  // (Workout.isSelected == true) 운동 출력
  // X버튼 클릭으로 운동 선택 해제
  // ==========================================
  Widget _printSelectedWorkoutList(int index) {
    if (_workoutList[index].isSelected) {
      return Row(
        children: [
          Text(_workoutList[index].name),
          IconButton(
            onPressed: () {
              setState(() {
                _workoutList[index].isSelected = false;
                _workoutList[index].color = Colors.white;
                _selectedWorkoutCounter--;
              });
            },
            icon: Icon(Icons.clear),
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
          // [#1] - 검색 기능
          // ==========================================
          Container(
            color: Colors.blue[50],
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // 검색 텍스트 에디터
                  TextField(
                    focusNode: _focusNode,
                    controller: _textEditingController,
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: '운동 검색',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _textEditingController.clear();
                          filterSearchResults('');
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  // 버튼 검색 (미구현)
                  Visibility(
                    visible: _isGroupButtonVisible,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GroupButton(
                        controller: _groupButtonController,
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
          ),

          // ==========================================
          // [#2] - 검색된 운동 목록 출력
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
          // Divider(
          //   thickness: 2.0,
          //   indent: 10,
          //   endIndent: 10,
          // ),

          // ==========================================
          // [#3] - 선택된 운동 목록 출력 장바구니
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
                    color: Colors.purple,
                    child: _printSelectedWorkoutList(index),
                  );
                },
              ),
            ),
          ),

          // ==========================================
          // [#4] - 세부 계획 입력 뷰 이동
          // ==========================================
          Container(
            color: Colors.green,
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              child: Text('Button Test'),
              onPressed: _isVisible()
                  ? () => Get.to(
                        WorkoutDetailPlanner(),
                        arguments: {
                          'selectedDay': _selectedDay,
                          'workoutList': _workoutList,
                        },
                      )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutForSearchAndSelect extends Workout {
  bool isSearched;
  bool isSelected;
  Color color;
  bool isFavorite = false;

  WorkoutForSearchAndSelect(String category, String name, this.isSearched,
      this.isSelected, this.color, this.isFavorite)
      : super(category, name);
}
