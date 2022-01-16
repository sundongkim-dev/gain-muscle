import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gain_muscle/src/pages/login.dart';
import 'package:gain_muscle/views/base_view.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (!snapshot.hasData) {
            return LoginWidget();
          } else {
            return BaseView();
          }
        },
      ),
    );
  }
}
