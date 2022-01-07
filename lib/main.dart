import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gain_muscle/src/app.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

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
  MyApp({Key? key, required this.cameras}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final List<CameraDescription> cameras;
  @override
  Widget build(BuildContext context) {
    print('myapp');

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return GetMaterialApp(
                home: App(
              cameras: cameras,
            ));
          }
          return CircularProgressIndicator();
        });

    // return GetMaterialApp(
    //     home: App(
    //   cameras: cameras,
    // ));
  }
}
