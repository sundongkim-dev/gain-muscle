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
  }
}
