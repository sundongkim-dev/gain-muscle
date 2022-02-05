import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:table_calendar/table_calendar.dart';

import 'meal_planner.dart';
import 'workout_planner.dart';
import 'workout_planner.dart';

enum RadioItems { workout, meal }

class WorkoutMealPlanner extends StatefulWidget {
  const WorkoutMealPlanner({Key? key}) : super(key: key);

  @override
  State<WorkoutMealPlanner> createState() => _WorkoutMealPlannerState();
}

class _WorkoutMealPlannerState extends State<WorkoutMealPlanner> {
  // 계획할 것 - 운동/식단
  RadioItems? _radioItems = RadioItems.workout;
  // 계획할 것에 따라 위젯 보임/숨김
  bool _visibility = true;

  final CalendarFormat _calendarFormat = CalendarFormat.week;
  // 선택 가능 날짜 임의 지정
  final DateTime kFirstDay = DateTime.utc(2021, 11, 1);
  final DateTime kLastDay = DateTime.utc(2022, 3, 1);

  // 이전 뷰(calendar_view)로부터 선택된 날짜 정보 받아 옴
  DateTime _focusedDay = Get.arguments;
  DateTime _selectedDay = Get.arguments;

  // 버튼 컨트롤러, 버튼 선택 기본값 '운동 계획'
  final GroupButtonController _groupButtonController = GroupButtonController(
    selectedIndex: 0,
  );

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              locale: 'ko-KR',
              calendarFormat: _calendarFormat,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
              focusedDay: _focusedDay,
              firstDay: kFirstDay,
              lastDay: kLastDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: _onDaySelected,
            ),
            Divider(
              thickness: 2.0,
              indent: 10.0,
              endIndent: 10.0,
            ),
            Expanded(
              child: Column(
                children: [
                  // 운동/식단 선택 라디오 버튼
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     // 운동 일지 기록 버튼
                  //     Row(
                  //       children: [
                  //         Radio<RadioItems>(
                  //           value: RadioItems.workout,
                  //           groupValue: _radioItems,
                  //           onChanged: (RadioItems? value) => setState(() {
                  //             _radioItems = value;
                  //             _visibility = true;
                  //           }),
                  //         ),
                  //         Text('운동 일지'),
                  //       ],
                  //     ),
                  //     // 식단 일지 기록 버튼
                  //     Row(
                  //       children: [
                  //         Radio<RadioItems>(
                  //           value: RadioItems.meal,
                  //           groupValue: _radioItems,
                  //           onChanged: (RadioItems? value) => setState(() {
                  //             _radioItems = value;
                  //             _visibility = false;
                  //           }),
                  //         ),
                  //         Text('식단 일지'),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  GroupButton.radio(
                    buttons: ['운동 일지', '식단 일지'],
                    controller: _groupButtonController,
                    onSelected: (index) {
                      setState(() {
                        if (index == 0) {
                          _visibility = true;
                        } else {
                          _visibility = false;
                        }
                      });
                    },
                    spacing: 0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // 라디오 버튼 - 운동 일 때
                  Visibility(
                    visible: _visibility,
                    child: ElevatedButton(
                      child: Text('운동 계획 생성'),
                      onPressed: () =>
                          Get.to(WorkoutPlanner(), arguments: _selectedDay),
                    ),
                  ),
                  Visibility(
                    visible: !_visibility,
                    child: ElevatedButton(
                      child: Text('식단 계획 생성'),
                      onPressed: () =>
                          Get.to(MealPlanner(), arguments: _selectedDay),
                    ),
                  ),
                  // 라디오 버튼 - 식단 일 때
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}