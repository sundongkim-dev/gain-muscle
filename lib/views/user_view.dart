import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User? user = FirebaseAuth.instance.currentUser;

class userView extends StatefulWidget {
  const userView({Key? key}) : super(key: key);

  @override
  _userViewState createState() => _userViewState();
}

class _userViewState extends State<userView> {
  String name = FirebaseAuth.instance.currentUser!.displayName as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "  프로필",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Center(
          child: Image(
            image: AssetImage("assets/Img/userviewImg/strong.png"),
            width: 200,
            height: 200,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            // "별명 들어가야 하는 부분",
            name,
            textAlign: TextAlign.center,
          ),
        ]),
        Row(
          children: [
            Expanded(child: Divider()),
            Expanded(child: Divider()),
          ],
        ),
        // Padding(
        //   padding: EdgeInsets.all(20),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       ElevatedButton.icon(
        //         onPressed: () {
        //           FirebaseAuth.instance.signOut();
        //         },
        //         label: Text("로그아웃"),
        //         icon: Icon(Icons.logout),
        //       ),
        //     ],
        //   ),
        // ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseAuth.instance.signOut(),
        child: Icon(Icons.logout),
        tooltip: "로그아웃",
      ),
    );
  }
}
