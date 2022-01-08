import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User? user = FirebaseAuth.instance.currentUser;

class userView extends StatefulWidget {
  const userView({Key? key}) : super(key: key);

  @override
  _userViewState createState() => _userViewState();
}

class _userViewState extends State<userView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "  프로필",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: Image(
                        image: AssetImage("assets/Img/userviewImg/strong.png"),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "별명 들어가야 하는 부분",
                            textAlign: TextAlign.center,
                          ),
                        ]
                    ),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Expanded(child: Divider()),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                },
                                label: Text("로그아웃"),
                                icon: Icon(Icons.logout),
                            ),
                          ],
                        ),
                    ),
                  ]
              ),
            )
          ],
        ));
  }
}
