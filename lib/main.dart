import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gain_muscle/src/app.dart';
import 'package:get/get.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

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
    return GetMaterialApp(
        // home: Image.asset('img/splashImg/splashImg.png')
        /*home: Center(
        child: Container(width:50, height:50, color:Colors.blue), // 사이즈 단위는 픽셀이 아닌 LP, 50LP == 1.2cm
      )*/
        home: App(
      cameras: cameras,
    ));
    // home: ChangeNotifierProvider(
    //     create: (context) => PageProvider(),
    //     child: BasicStructure(cameras: cameras)));
  }
}
