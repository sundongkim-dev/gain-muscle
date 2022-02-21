import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class calendarView extends StatefulWidget {
  const calendarView({Key? key}) : super(key: key);

  @override
  _calendarViewState createState() => _calendarViewState();
}

class _calendarViewState extends State<calendarView> {
  // 기본 달력 표시 단위는 월간
  CalendarFormat _calendarFormat = CalendarFormat.month;
  bool _currentFormat = true;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  // 선택 가능 날짜 임의 지정
  DateTime kFirstDay = DateTime.utc(2021, 1, 15);
  DateTime kLastDay = DateTime.utc(2025, 1, 20);
  
  // 데이터 받아와서 처리
  String userName = FirebaseAuth.instance.currentUser!.displayName as String;
  List<dynamic> routine = [];
  Future<void> getData() async {
    CollectionReference recordDB =
    FirebaseFirestore.instance.collection('user/$userName/record');
    print('데이터를 받아옵니다.');
    String today = _focusedDay.year.toString() +
        _focusedDay.month.toString() +
        _focusedDay.day.toString();
    // Get docs from collection reference
    DocumentSnapshot docsnapshot = await recordDB.doc(today).get();
    if (docsnapshot.data() == null) {
      routine = [];
      return;
    }
    print('데이터를 받아옵니다.2');
    Map<String, dynamic> record = docsnapshot.data() as Map<String, dynamic>;
    // routine = jsonDecode(record['data']) as Map<String, dynamic>;
    routine = jsonDecode(record['data']) as List<dynamic>;
    print(routine);
    print('데이터를 받아옵니다.3');
  }
  
  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _currentFormat = true;
  }

  // 선택된 날짜 포커스
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }
  // 월간 - 주간 변환
  void _onFormatChanged(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
      format == CalendarFormat.month ? _currentFormat = true : _currentFormat = false;
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
              calendarFormat: _calendarFormat,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
                CalendarFormat.week: 'Week'
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                headerMargin: EdgeInsets.only(left: 0, top: 10, right: 40, bottom: 10),
                titleCentered: true,
                leftChevronIcon: Icon(
                  Icons.arrow_left,
                  size: 40,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_right,
                  size: 40,
                ),
                rightChevronPadding: EdgeInsets.fromLTRB(0, 0, 100, 0)
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.black),
                  weekendStyle: TextStyle(color: Colors.black)),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: true,
                outsideTextStyle: TextStyle().copyWith(color: Colors.grey),
                weekendTextStyle: TextStyle().copyWith(color: Colors.blue[800]),
                selectedDecoration: BoxDecoration(
                    color: const Color(0xFFa8d8ea), shape: BoxShape.circle),
                holidayTextStyle: TextStyle().copyWith(color: Colors.red[800]),
                holidayDecoration: const BoxDecoration(),
              ),
              holidayPredicate: (day) {
                return day.weekday == DateTime.sunday;
              },
              onFormatChanged: (format) => _onFormatChanged(format),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: _onDaySelected,
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            Divider(
              thickness: 2.0,
              indent: 10.0,
              endIndent: 10.0,
            ),
            _calendarFormat == CalendarFormat.month
              ? FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    // 월간이면서 저장된 루틴이 없다면, 게획하기 버튼으로
                    if(routine.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(DateFormat('yyyy년 MM월 dd일').format(_selectedDay)),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            child: Text('계획하기'),
                            onPressed: () => _onFormatChanged(CalendarFormat.week),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          for(int i=0; i<routine.length; i++)
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                              child: Card(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: Text(
                                            routine[i][0],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    for (int j = 0;
                                    j < routine[i][1];
                                    j++)
                                    // 지금 이부분이 텍스트 컨트롤러를 넣기위해서 만든 부분인데
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                5, 10, 5, 10),
                                            child: Text(
                                                '${j + 1}   ${routine[i][2][j][0]} kg   ${routine[i][2][j][1]} 회'),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                })
              : FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    if(routine.isEmpty) {
                      return Column(
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
                                /*Get.to(() => WorkoutPlanner(
                                    today: _focusedDay));
                                setState(() {});*/
                              },
                              label: Text('득근루틴 짜러가기'),
                              icon: Icon(Icons.shopping_cart),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                FloatingActionButton.extended(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  onPressed: () async {
                                    // Get.to(() =>
                                    //     loadExerciseView(today: widget.today));
                                    /*Get.to(() => loadExerciseView(
                                        today: _focusedDay));
                                    setState(() {});*/
                                  },
                                  label: Text('불러오기'),
                                  heroTag: null,
                                ),
                                FloatingActionButton.extended(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  onPressed: () {}/*=>
                                      Get.find<Controller>().rest()*/,
                                  label: Text('휴식하기'),
                                  heroTag: null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          for (int i = 0; i < routine.length; i++)
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                              child: Card(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          child: Text(
                                            routine[i][0],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    for (int j = 0; j < routine[i][1]; j++)
                                    // 지금 이부분이 텍스트 컨트롤러를 넣기위해서 만든 부분인데
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                5, 10, 5, 10),
                                            child: Text(
                                                '${j + 1}   ${routine[i][2][j][0]} kg   ${routine[i][2][j][1]} 회'),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
