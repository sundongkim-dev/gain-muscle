import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

User? user = FirebaseAuth.instance.currentUser;

class userView extends StatefulWidget {
  const userView({Key? key}) : super(key: key);

  @override
  _userViewState createState() => _userViewState();
}

class _userViewState extends State<userView> {
  String name = FirebaseAuth.instance.currentUser!.displayName as String;
  /*void _sendEmail() async {
    final Email email = Email(
      body: '',
      subject:
    )
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "    프로필",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Center(
                child: Image(
                  image: AssetImage("assets/Img/userviewImg/strong.png"),
                  width: 80,
                  height: 80,
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.center,
                    ),
                  ]
              ),
              Expanded(
                child: SingleChildScrollView(
                  child:
                    Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 18),
                                primary: Colors.black,
                                onSurface: Colors.red,
                              ),
                              onPressed: () {},
                              label: Text("프로필 변경하기"),
                              icon: Icon(Icons.person),
                            ),
                            Divider(indent: 10, thickness: 1.5,),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 18),
                                primary: Colors.black,
                                onSurface: Colors.red,
                              ),
                              onPressed: () {},
                              label: Text("컬러 테마 설정"),
                              icon: Icon(Icons.palette),
                            ),
                            Divider(indent: 10, thickness: 1.5,),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 18),
                                primary: Colors.black,
                                onSurface: Colors.red,
                              ),
                              onPressed: () {},
                              label: Text("회원 탈퇴하기"),
                              icon: Icon(Icons.palette),
                            ),
                            Text("\n  쓰담쓰담 한마디\n"),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 18),
                                primary: Colors.black,
                                onSurface: Colors.red,
                              ),
                              onPressed: () {
                                //_sendEmail();
                              },
                              label: Text("피드백 보내기"),
                              icon: Icon(Icons.chat),
                            ),
                            Divider(indent: 10, thickness: 1.5,),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 18),
                                primary: Colors.black,
                                onSurface: Colors.red,
                              ),
                              onPressed: () {},
                              label: Text("앱 평점주기 / 리뷰"),
                              icon: Icon(Icons.thumb_up_alt),
                            ),
                            Text("\n  득근이와 소통하기\n"),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 18),
                                primary: Colors.black,
                                onSurface: Colors.red,
                              ),
                              onPressed: () {},
                              label: Text("카페 구경가기"),
                              icon: Icon(Icons.local_cafe_rounded),
                            ),
                            Divider(indent: 10, thickness: 1.5,),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 18),
                                primary: Colors.black,
                                onSurface: Colors.red,
                              ),
                              onPressed: () {},
                              label: Text("득근이 인스타그램"),
                              icon: Icon(Icons.camera_alt_outlined),
                            ),
                            Divider(indent: 10, thickness: 1.5,),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 18),
                                primary: Colors.black,
                                onSurface: Colors.red,
                              ),
                              onPressed: () {},
                              label: Text("개발자 소개"),
                              icon: Icon(Icons.computer),
                            ),
                          ],
                    ),
              ),
              ),
            ]
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => FirebaseAuth.instance.signOut(),
          child: Icon(Icons.logout),
          tooltip: "로그아웃",
      ),
    );
  }
}
