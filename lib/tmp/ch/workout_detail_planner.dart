import 'package:flutter/material.dart';
import 'package:gain_muscle/tmp/ch/workout_planner.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'temp_workout_list.dart';

class WorkoutDetailPlanner extends StatefulWidget {
  const WorkoutDetailPlanner({Key? key}) : super(key: key);

  @override
  State<WorkoutDetailPlanner> createState() => _WorkoutDetailPlannerState();
}

class _WorkoutDetailPlannerState extends State<WorkoutDetailPlanner> {
  // 선택 가능 날짜 임의 지정
  final DateTime kFirstDay = DateTime.utc(2021, 11, 1);
  final DateTime kLastDay = DateTime.utc(2022, 3, 1);

  final CalendarFormat _calendarFormat = CalendarFormat.week;
  // 이전 뷰(workout_planner)로 부터 체크된 운동 목록 받아 옴
  final DateTime _selectedDay = Get.arguments['selectedDay'];
  final DateTime _focusedDay = Get.arguments['selectedDay'];
  final List<WorkoutForSearchAndSelect> _workoutList =
      Get.arguments['workoutList'];

  // ==========================================
  // 선택된 운동 출력
  // ==========================================
  Widget _printSelectedWorkoutList(int index) {
    if (_workoutList[index].isSelected) {
      return Card(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_workoutList[index].toString()),
                    SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: FloatingActionButton(
                        child: Icon(
                          Icons.delete,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2.0,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
                Text('Test'),
                Text('세트 / 무게 / 횟수'),
              ],
            )),
      );
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ## 달력? 앱바?
            TableCalendar(
              locale: 'ko-KR',
              calendarFormat: _calendarFormat,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
              focusedDay: _focusedDay,
              firstDay: kFirstDay,
              lastDay: kLastDay,
            ),
            Divider(
              thickness: 2.0,
              indent: 10.0,
              endIndent: 10.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _workoutList.length,
                  itemBuilder: (context, index) {
                    return _printSelectedWorkoutList(index);
                  },
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
              indent: 10.0,
              endIndent: 10.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: ElevatedButton(
                child: Text('기록 완료'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
