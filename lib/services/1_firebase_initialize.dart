import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '2_check_auth.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
          return chkAuth();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
