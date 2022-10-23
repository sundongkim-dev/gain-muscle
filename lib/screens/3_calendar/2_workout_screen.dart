import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gain_muscle/data/workout.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';


class workoutView extends StatefulWidget {
  const workoutView({Key? key}) : super(key: key);

  @override
  _workoutViewState createState() => _workoutViewState();
}

class _workoutViewState extends State<workoutView> {
  final FocusNode _focusNode = FocusNode(); // 포커스 노드 어따쓰누

  final DateTime _selectedDay = Get.arguments; // 계획하는 날짜 calendar_screen에서 받아옴
  final TextEditingController _textEditingController = TextEditingController(); // 운동 검색용 컨트롤러


  final GroupButtonController _groupButtonController = GroupButtonController(); // 운동 카테고리 필터 컨트롤러
  final List<String> _buttons = ['전체', '가슴', '어깨', '등', '팔', '하체', '유산소']; // 운동 카테고리 종류

  int _selectedWorkoutCounter = 0;
  final List<WorkoutForSearchAndSelect> _workoutList =
  List<WorkoutForSearchAndSelect>.generate(
      workoutList.length,
          (index) =>
          WorkoutForSearchAndSelect(workoutList[index].category,
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
  // #1 그룹버튼 검색 비활성화
  // 텍스트필드를 이용해 검색할 때 그룹 버튼 비활성화
  // 텍스트필드 포커스 해제될 때 그룹 버튼 초기화
  // ** 텍스트 입력 안하고 텍스트필드 X버튼(전체 포커스 해제) 눌러도 초기화 되는데 버튼은 안사라짐
  // ==========================================
  void _onFocusChanged() {

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

    @override
    Widget build(BuildContext context) {
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
                          DateFormat('MM월 dd일 운동 계획').format(_selectedDay),
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    )
                ),
                // ==========================================
                // [#1] - 운동 검색 기능
                // ==========================================
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                  child: TextField(
                      focusNode: _focusNode,
                      controller: _textEditingController,
                      onChanged: (value) {

                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _textEditingController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        labelText: '운동을 검색해보세요',
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GroupButton(
                      isRadio: true,
                      controller: _groupButtonController,
                      buttons: _buttons,
                      borderRadius: BorderRadius.circular(30.0),
                      unselectedBorderColor: Colors.grey[500],
                      unselectedColor: Colors.white,
                      onSelected: (index, isSelected) {
                        filterSearchResults(_buttons[index]);
                      },
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
                Divider(
                  thickness: 2,
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  onPressed: () {},
                  label: Text('운동 담기'),
                  icon: Icon(Icons.shopping_cart),
                ),
                SizedBox(height: 15.0,),
              ],
            ),
          )
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
