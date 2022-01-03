import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gain_muscle/src/pages/home.dart';

class App extends StatelessWidget {

  const App({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(), // firebase 연결
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          // firebase 연결 실패
          return Center(
            child: Text("Firebase load fail"),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // firebase 연결 성공
          return Home(
            cameras: cameras,
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
