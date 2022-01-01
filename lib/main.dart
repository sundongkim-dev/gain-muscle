import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gain_muscle/provider/page_provider.dart';
import 'package:gain_muscle/views/home_view.dart';
import 'package:gain_muscle/views/item_view.dart';
import 'package:gain_muscle/views/record_view.dart';
import 'package:gain_muscle/views/user_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // bool data = await fetchData();
  // print(data);
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  // final rearCamera = cameras.first; // 핸드폰 뒤쪽 카메라
  // final frontCamera = cameras.last; // 핸드폰 앞쪽 카메라
  // print('main!!');
  runApp(MyApp(cameras: cameras)); // 앱 시작
}

// // 앱 메인페이지
// // 앱 디자인: 위젯 짜깁기

// 글자: Text
// 아이콘: Icon(Icons.아이콘이름)
// 이미지: Image.asset('경로')
// 네모박스: Container()

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;
  @override
  Widget build(BuildContext context) {
    print('myapp');
    return MaterialApp(
        // home: Image.asset('img/splashImg/splashImg.png')
        /*home: Center(
        child: Container(width:50, height:50, color:Colors.blue), // 사이즈 단위는 픽셀이 아닌 LP, 50LP == 1.2cm
      )*/
        home: ChangeNotifierProvider(
            create: (context) => PageProvider(),
            child: BasicStructure(cameras: cameras)));
  }
}

class BasicStructure extends StatelessWidget {
  const BasicStructure({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;
  @override
  Widget build(BuildContext context) {
    final List _page = [
      homeView(cameras: cameras),
      recordView(),
      itemView(),
      userView()
    ];
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    print('basicstructure');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff84ffff),
          leading: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          title: Text('넌 이미 운동을 하고 있다'),
        ),
        body: _page[pageProvider.idx],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          onTap: pageProvider.changePage,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(
                icon: Icon(Icons.audiotrack), label: '운동기록'),
            BottomNavigationBarItem(
                icon: Icon(Icons.beach_access), label: '아이템,칭호'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '사용자계정'),
          ],
        ));
  }
}

Future<bool> fetchData() async {
  bool data = false;

  // Change to API call
  await Future.delayed(Duration(seconds: 1), () {
    data = true;
  });
  return data;
}
