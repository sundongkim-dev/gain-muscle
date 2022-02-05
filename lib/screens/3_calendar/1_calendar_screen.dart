import 'package:flutter/material.dart';
import 'package:gain_muscle/tmp/controller.dart';
import 'package:gain_muscle/tmp/event.dart';
import 'package:gain_muscle/tmp/exercise_input.dart';
import 'package:gain_muscle/tmp/exercise_record_view.dart';
import 'package:gain_muscle/tmp/load_exercise_view.dart';
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

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    return GetBuilder<Controller>(builder: (_) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                locale: 'ko-KR',
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                  CalendarFormat.week: 'Week'
                },
                headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    headerMargin: EdgeInsets.only(
                        left: 0, top: 10, right: 40, bottom: 10),
                    titleCentered: true,
                    leftChevronIcon: Icon(
                      Icons.arrow_left,
                      size: 40,
                    ),
                    rightChevronIcon: Icon(
                      Icons.arrow_right,
                      size: 40,
                    ),
                    rightChevronPadding: EdgeInsets.fromLTRB(0, 0, 100, 0)),
                holidayPredicate: (day) {
                  return day.weekday == DateTime.saturday;
                },
                // 평일, 주말 나누기
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.black),
                    weekendStyle: TextStyle(color: Colors.black)),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: true,
                  weekendTextStyle:
                      TextStyle().copyWith(color: Colors.blue[800]),
                  // 오늘 뭐 안뜨게 하려면 기본이랑 똑같게 설정해놔야하는데 나중에 하자 조낸 귀찮다
                  todayDecoration: BoxDecoration(shape: BoxShape.circle),
                  todayTextStyle: TextStyle(),
                  selectedDecoration: BoxDecoration(
                      color: const Color(0xFFa8d8ea), shape: BoxShape.circle),
                  holidayTextStyle:
                      TextStyle().copyWith(color: Colors.red[800]),
                  holidayDecoration: const BoxDecoration(),
                ),

                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },

                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                      if (format == CalendarFormat.month) {
                        _.updateFormat(true);
                      } else {
                        _.updateFormat(false);
                      }
                    });
                  }
                },
                // 다른 달 넘어가도 focus 변경 없게끔
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              Divider(
                thickness: 2.0,
                indent: 10,
                endIndent: 10,
              ),
              _.isMonth
                  ? Container(
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
                  : Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                            child: Column(
                              children: [
                                Text('알통몬'),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://static.wikia.nocookie.net/pokemon/images/3/3a/%EC%95%8C%ED%86%B5%EB%AA%AC_%EA%B3%B5%EC%8B%9D_%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8.png/revision/latest?cb=20170405013322&path-prefix=ko'),
                                          fit: BoxFit.fill)),
                                  width: 250,
                                  height: 250,
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    '3대300',
                                    style: TextStyle(
                                        backgroundColor: Colors.white,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 40, 0, 30),
                            child: FloatingActionButton.extended(
                              onPressed: () async {
                                // Get.to(() => exerciseInputView(today: widget.today));
                                Get.to(() =>
                                    exerciseInputView(today: _focusedDay));
                                setState(() {});
                              },
                              label: Text('득근루틴 짜러가기'),
                              icon: Icon(Icons.shopping_cart),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FloatingActionButton.extended(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  onPressed: () async {
                                    // Get.to(() =>
                                    //     loadExerciseView(today: widget.today));
                                    Get.to(() =>
                                        loadExerciseView(today: _focusedDay));
                                    setState(() {});
                                  },
                                  label: Text('불러오기'),
                                  heroTag: null,
                                ),
                                FloatingActionButton.extended(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  onPressed: () =>
                                      Get.find<Controller>().rest(),
                                  label: Text('휴식하기'),
                                  heroTag: null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      );
    });
  }
}
