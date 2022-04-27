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
  // 달력에서 선택 가능한 날짜 임의 지정(조정 가능)
  DateTime kFirstDay = DateTime.utc(2021, 1, 15);
  DateTime kLastDay = DateTime.utc(2025, 1, 20);

  // 달력 표시 단위 기본값: 월간
  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  // 데이터 받아와서 처리
  String userName = FirebaseAuth.instance.currentUser!.displayName as String;
  List<dynamic> routine = [];
  Future<void> getData() async {
    // CollectionReference recordDB =
    //     FirebaseFirestore.instance.collection('user/$userName/record');
    // print('데이터를 받아옵니다.');
    // String today = _focusedDay.year.toString() +
    //     _focusedDay.month.toString() +
    //     _focusedDay.day.toString();
    // // Get docs from collection reference
    // DocumentSnapshot docsnapshot = await recordDB.doc(today).get();
    // if (docsnapshot.data() == null) {
    //   routine = [];
    //   return;
    // }
    // print('데이터를 받아옵니다.2');
    // Map<String, dynamic> record = docsnapshot.data() as Map<String, dynamic>;
    // // routine = jsonDecode(record['data']) as Map<String, dynamic>;
    // routine = jsonDecode(record['data']) as List<dynamic>;
    // print(routine);
    // print('데이터를 받아옵니다.3');
  }

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
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
                CalendarFormat.month: '월간',
                CalendarFormat.week: '주간'
              },
              // headerStyle: HeaderStyle(
              //   formatButtonVisible: false,
              //   headerMargin: EdgeInsets.only(left: 0, top: 10, right: 40, bottom: 10),
              //   titleCentered: true,
              //   leftChevronIcon: Icon(
              //     Icons.arrow_left,
              //     size: 40,
              //   ),
              //   rightChevronIcon: Icon(
              //     Icons.arrow_right,
              //     size: 40,
              //   ),
              //   rightChevronPadding: EdgeInsets.fromLTRB(0, 0, 100, 0)
              // ),
              // daysOfWeekStyle: DaysOfWeekStyle(
              //     weekdayStyle: TextStyle(color: Colors.black),
              //     weekendStyle: TextStyle(color: Colors.red),
              // ),
              // calendarStyle: CalendarStyle(
              //   outsideDaysVisible: true,
              //   outsideTextStyle: TextStyle().copyWith(color: Colors.grey),
              //   weekendTextStyle: TextStyle().copyWith(color: Colors.blue[800]),
              //   holidayTextStyle: TextStyle().copyWith(color: Colors.red[800]),
              //   holidayDecoration: const BoxDecoration(),
              // ),
              // holidayPredicate: (day) {
              //   return (day.weekday == DateTime.sunday) && (day.month == DateTime.now().month);
              // },
              headerStyle: HeaderStyle(
                formatButtonShowsNext: false,
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(
                  color: Colors.red,
                ),
              ),
              calendarStyle: CalendarStyle(
                weekendTextStyle: TextStyle(
                  color: Colors.red,
                ),
              ),
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
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                DateFormat('yyyy년 MM월 dd일').format(_selectedDay),
              ),
            ),
            // ==========================
            // 달력 형식: 월간
            // ==========================
            _calendarFormat == CalendarFormat.month
                ? FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return CircularProgressIndicator();
                      } else {
                        // 월간이면서 저장된 루틴이 없다면, 게획하기 버튼으로
                        if (routine.isEmpty) {
                          return ElevatedButton(
                            onPressed: () =>
                                _onFormatChanged(CalendarFormat.week),
                            child: Text('Planning'),
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
                      }
                    })
                // ==========================
                // 달력 형식: 주간
                // ==========================
                : FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (routine.isEmpty) {
                          return Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text('#User Power#')),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Image(
                                  image: AssetImage(
                                      "assets/Img/userviewImg/strong.png"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text('#User Image#'),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: FloatingActionButton.extended(
                                  onPressed: () { },
                                  label: Text('득근루틴 짜러가기'),
                                  icon: Icon(Icons.shopping_cart),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FloatingActionButton.extended(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      onPressed: () { },
                                      label: Text('불러오기'),
                                      heroTag: null,
                                    ),
                                    FloatingActionButton.extended(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      onPressed: () { },
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
