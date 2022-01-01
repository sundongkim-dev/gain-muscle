import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gain_muscle/src/app.dart';

Future<void> main() async {
  //bool data = await fetchData();
  //print(data);

  runApp(MyApp());      // 앱 시작
}

// 앱 메인페이지
// 앱 디자인: 위젯 짜깁기
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Image.asset('img/splashImg/splashImg.png')
      /*home: Center(
        child: Container(width:50, height:50, color:Colors.blue), // 사이즈 단위는 픽셀이 아닌 LP, 50LP == 1.2cm
      )*/
      title: "SNS login with Firebase Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),

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
  await Future.delayed(Duration(seconds: 1), () {
    data = true;
  });
  return data;
}

