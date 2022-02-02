import 'package:flutter/material.dart';
import 'package:gain_muscle/tmp/event.dart';
import 'package:gain_muscle/tmp/exercise_record_view.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class calendarView extends StatefulWidget {
  const calendarView({Key? key}) : super(key: key);

  @override
  _calendarViewState createState() => _calendarViewState();
}

class _calendarViewState extends State<calendarView> {
  Map<DateTime, List<Event>> selectedEvents = {};
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  // 선택 가능 날짜 임의 지정
  DateTime kFirstDay = DateTime.utc(2021, 1, 15);
  DateTime kLastDay = DateTime.utc(2025, 1, 20);

  List<Event> _getEventsFromDate(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    print('빌드 다시함');
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            locale: 'ko-KR',
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarFormat: _calendarFormat,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              headerMargin:
                  EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 10),
              titleCentered: true,
              leftChevronIcon: Icon(Icons.arrow_left),
              rightChevronIcon: Icon(Icons.arrow_right),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.black),
                weekendStyle: TextStyle(color: Colors.blue[800])),
            // holidayPredicate: (day) {
            //   return day.weekday == DateTime.saturday;
            // },
            calendarStyle: CalendarStyle(
              outsideDaysVisible: true,
              weekendTextStyle: TextStyle().copyWith(color: Colors.blue[800]),
              // 오늘 뭐 안뜨게 하려면 기본이랑 똑같게 설정해놔야하는데 나중에 하자 조낸 귀찮다
              todayDecoration: BoxDecoration(shape: BoxShape.circle),
              todayTextStyle: TextStyle(),
              selectedDecoration: BoxDecoration(
                  color: const Color(0xFFa8d8ea), shape: BoxShape.circle),
              // holidayTextStyle: TextStyle().copyWith(color: Colors.blue[800]),
              // holidayDecoration: const BoxDecoration(),
            ),

            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  print('focused Day $focusedDay');
                  _selectedDay = selectedDay;
                  // _focusedDay = selectedDay;
                  _focusedDay = focusedDay;
                  print('selected day $selectedDay, focused day $focusedDay');
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
          // Expanded(
          //     child: Container(
          //   color: Color(0xfff0f0f0).withOpacity(0.2),
          //   child: Column(
          //     children: [
          //       OutlinedButton(onPressed: null, child: Text('득근하러가기'))
          //     ],
          //   ),
          // )),
          // ..._getEventsFromDate(_focusedDay).map((Event event) => ListTile(
          //       title: Text(
          //         event.title,
          //       ),
          //     )),
          Divider(
            thickness: 2.0,
            indent: 10,
            endIndent: 10,
          ),
          Container(
            // color: Color.,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(_focusedDay.month.toString() +
                    "월" +
                    _focusedDay.day.toString() +
                    "일"),
                SizedBox(
                  height: 20,
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    Get.to(() => exerciseRecordView(
                          selectedDay: _focusedDay,
                        ));
                  },
                  label: Text('득근하러 가기'),
                  icon: Icon(Icons.shopping_cart),
                ),
              ],
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     if (selectedEvents[_focusedDay] != null) {
      //       selectedEvents[_focusedDay]?.add(Event(title: "우하하 오늘의 운동을 더해주마"));
      //     } else {
      //       selectedEvents[_focusedDay] = [Event(title: "우하하 나도 운동할테다")];
      //     }
      //   },
      //   label: Text('득근하러 가기'),
      //   icon: Icon(Icons.shopping_cart),
      // ),
    );
  }
}
