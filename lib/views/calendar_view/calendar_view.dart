import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'workout_meal_planner.dart';

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

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
  }

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('yyyy년 MM월 dd일').format(_selectedDay!)),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ElevatedButton(
                    child: Text('계획하기'),
                    onPressed: () => Get.to(WorkoutMealPlanner(), arguments: _selectedDay),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
