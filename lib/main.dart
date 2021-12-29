import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gain_muscle/views/home_view.dart';
import 'package:gain_muscle/views/item_view.dart';
import 'package:gain_muscle/views/record_view.dart';
import 'package:gain_muscle/views/user_view.dart';

Future<void> main() async {
  // bool data = await fetchData();
  // print(data);

  runApp(const MyApp()); // 앱 시작
}

// 앱 메인페이지
// 앱 디자인: 위젯 짜깁기
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIdx = 0;
  final List _page = [homeView(), recordView(), itemView(), userView()];

  void changePage(int idx) {
    setState(() {
      currentIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Image.asset('img/splashImg/splashImg.png')
      /*home: Center(
        child: Container(width:50, height:50, color:Colors.blue), // 사이즈 단위는 픽셀이 아닌 LP, 50LP == 1.2cm
      )*/
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff84ffff),
            leading: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: Text('넌 이미 운동을 하고 있다'),
          ),
          body: _page[currentIdx],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.grey,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            onTap: changePage,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.audiotrack), label: '운동기록'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.beach_access), label: '아이템,칭호'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: '사용자계정'),
            ],
          )),
    );
  }
}
// 글자: Text
// 아이콘: Icon(Icons.아이콘이름)
// 이미지: Image.asset('경로')
// 네모박스: Container()

Future<bool> fetchData() async {
  bool data = false;

  // Change to API call
  await Future.delayed(Duration(seconds: 3), () {
    data = true;
  });
  return data;
}
