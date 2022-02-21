import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'meal_planner.dart';
import 'temp_workout_meal_planner.dart';
import '../../screens/3_calendar/workout_planner.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // 선택 가능 날짜 임의 지정
  final DateTime kFirstDay = DateTime.utc(2021, 11, 1);
  final DateTime kLastDay = DateTime.utc(2022, 3, 1);

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Calendar Format: true->month, false->week
  bool _currentFormat = true;

  bool _visibility = true;
  final GroupButtonController _groupButtonController = GroupButtonController(
    selectedIndex: 0,
  );

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _currentFormat = true;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void _onFormatChanged(CalendarFormat format) {
    setState(() {
      // Format Change except 2week format
      // month -> week
      if (format == CalendarFormat.twoWeeks && _currentFormat == true) {
        _calendarFormat = CalendarFormat.week;
        _currentFormat = false;
      }
      // week -> month
      else if (format == CalendarFormat.twoWeeks && _currentFormat == false) {
        _calendarFormat = CalendarFormat.month;
        _currentFormat = true;
      } else {
        _calendarFormat = format;
        format == CalendarFormat.month
            ? _currentFormat = true
            : _currentFormat = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              locale: 'ko-KR',
              focusedDay: _focusedDay,
              firstDay: kFirstDay,
              lastDay: kLastDay,
              headerStyle: HeaderStyle(
                // formatButtonVisible: false,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) => _onFormatChanged(format),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: _onDaySelected,
            ),
            Divider(
              thickness: 2.0,
              indent: 10.0,
              endIndent: 10.0,
            ),
            // ==========================================
            // 달력 포맷: month
            // ==========================================
            Visibility(
              visible: _currentFormat,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(DateFormat('yyyy년 MM월 dd일').format(_selectedDay!)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    ElevatedButton(
                      child: Text('계획하기'),
                      onPressed: () => _onFormatChanged(CalendarFormat.week),
                    ),
                  ],
                ),
              ),
            ),
            // ==========================================
            // 달력 포맷: week
            // 운동 혹은 식단 추가 버튼 활성화
            // ==========================================
            Visibility(
              visible: !_currentFormat,
              child: Expanded(
                child: Column(
                  children: [
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

                    // '운동 일지' 버튼 선택했을 때
                    Visibility(
                      visible: _visibility,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Image.asset('assets/Img/userviewImg/strongColored.png'),
                          ),
                          ElevatedButton(
                            child: Text('운동 계획 생성'),
                            onPressed: () =>
                                Get.to(WorkoutPlanner(), arguments: _selectedDay),
                          ),
                        ],
                      ),
                    ),
                    // '식단 일지' 버튼 선택했을 때
                    Visibility(
                      visible: !_visibility,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Image.asset('assets/Img/userviewImg/hamburger.png'),
                          ),
                          ElevatedButton(
                            child: Text('식단 계획 생성'),
                            onPressed: () =>
                                Get.to(MealPlanner(), arguments: _selectedDay),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}