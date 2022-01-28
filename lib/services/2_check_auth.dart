import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gain_muscle/screens/0_login/1_login_screen.dart';
import 'package:gain_muscle/screens/0_login/2_base_screen.dart';

class chkAuth extends StatelessWidget {
  const chkAuth({Key? key}) : super(key: key);

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
