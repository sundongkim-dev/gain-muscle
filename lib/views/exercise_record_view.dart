import 'package:flutter/material.dart';
import 'package:gain_muscle/src/controller.dart';
import 'package:gain_muscle/views/exercise_input.dart';
import 'package:gain_muscle/views/load_exercise_view.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class exerciseRecordView extends StatefulWidget {
  const exerciseRecordView({Key? key, required this.selectedDay})
      : super(key: key);
  final DateTime selectedDay;
  @override
  _exerciseRecordViewState createState() => _exerciseRecordViewState();
}

class _exerciseRecordViewState extends State<exerciseRecordView> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  // DateTime? _selectedDay;
  DateTime _selectedDay = DateTime.now();
  DateTime kFirstDay = DateTime.utc(2021, 1, 15);
  DateTime kLastDay = DateTime.utc(2025, 1, 20);

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.selectedDay;
    _selectedDay = widget.selectedDay;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    return GetBuilder<Controller>(builder: (_) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            TableCalendar(
              locale: 'ko-KR',
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarFormat: _calendarFormat,
              availableCalendarFormats: {CalendarFormat.week: 'Week'},
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
                  weekendStyle: TextStyle(color: Colors.black)),
              calendarStyle: CalendarStyle(
                weekendTextStyle: TextStyle(),
                outsideDaysVisible: true,
                todayDecoration: BoxDecoration(shape: BoxShape.circle),
                todayTextStyle: TextStyle(),
                selectedDecoration: BoxDecoration(
                    color: const Color(0xFFa8d8ea), shape: BoxShape.circle),
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
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
            ),
            Divider(
              thickness: 2.0,
              indent: 10,
              endIndent: 10,
            ),
            _.isTodayRest
                ? restView(today: _selectedDay)
                : basicView(today: _selectedDay)
          ],
        ),
      );
    });
  }
}

class restView extends StatefulWidget {
  const restView({Key? key, required this.today}) : super(key: key);

  final DateTime today;
  @override
  _restViewState createState() => _restViewState();
}

class _restViewState extends State<restView> {
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                  child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.event_note_outlined),
                        border: OutlineInputBorder(),
                        labelText: '오늘의 메모',
                      )),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Image.asset('assets/Img/userviewImg/chicken.png')),
                Text(
                  '오늘은 치킨이닭!',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: FloatingActionButton.extended(
                    onPressed: () => Get.find<Controller>().cancel(),
                    backgroundColor: Color(0xfffafafa).withOpacity(0.6),
                    foregroundColor: Colors.black,
                    label: Text('휴식 취소'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class basicView extends StatefulWidget {
  const basicView({Key? key, required this.today}) : super(key: key);

  final DateTime today;
  @override
  _basicViewState createState() => _basicViewState();
}

class _basicViewState extends State<basicView> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  width: 300,
                  height: 300,
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '3대300',
                    style: TextStyle(
                        backgroundColor: Colors.white, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 30),
            child: FloatingActionButton.extended(
              onPressed: () async {
                Get.to(() => exerciseInputView(today: widget.today));
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
                    Get.to(() => loadExerciseView(today: widget.today));
                    setState(() {});
                  },
                  label: Text('불러오기'),
                  heroTag: null,
                ),
                FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  onPressed: () => Get.find<Controller>().rest(),
                  label: Text('휴식하기'),
                  heroTag: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
