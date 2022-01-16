import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gain_muscle/src/app.dart';
import 'package:gain_muscle/src/icons.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('myapp');
    return GetMaterialApp(
      home: App(),
      theme: ThemeData(fontFamily: 'gotgam'),
    );
  }
}
