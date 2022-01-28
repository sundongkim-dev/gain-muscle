import 'package:flutter/material.dart';

import '../1_home/1_home_screen.dart';
import '../2_statistic/1_record_screen.dart';
import '../3_calendar/1_calendar_screen.dart';
import '../4_item/1_item_screen.dart';
import '../5_userInfo/1_userInfo_screen.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int _idx = 0;
  final List _page = [
    homeView(),
    RecordView(),
    calendarView(),
    itemView(),
    userView()
  ];

  void onTabTapped(int idx) {
    setState(() {
      _idx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('basicstructure');
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xff84ffff),
      //   leading: Icon(
      //     Icons.favorite,
      //     color: Colors.red,
      //   ),
      //   title: Text(
      //     '득근득근',
      //     style: TextStyle(color: Colors.black),
      //   ),
      // ),
      body: _page[_idx],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue.shade300,
        unselectedItemColor: Colors.black.withOpacity(.60),
        currentIndex: _idx,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.audiotrack), label: '운동기록'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: '달력'),
          BottomNavigationBarItem(
              icon: Icon(Icons.beach_access), label: '아이템,칭호'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '사용자계정'),
        ],
      ),
    );
  }
}
