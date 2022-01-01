import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gain_muscle/provider/page_provider.dart';
import 'package:gain_muscle/src/pages/login.dart';
import 'package:gain_muscle/views/base_view.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key, required this.cameras}) : super(key: key);
  final List<CameraDescription> cameras;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (!snapshot.hasData) {
            return LoginWidget();
          } else {
            return MaterialApp(
                home: ChangeNotifierProvider(
                    create: (context) => PageProvider(),
                    child: BaseView(cameras: cameras)));
          }
        },
      ),
    );
  }
}
