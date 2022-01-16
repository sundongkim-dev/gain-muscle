import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  void showToast(String str) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  InkWell stuff(String name, IconData icon) {
    return InkWell(
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              color: Colors.black45,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              name,
              style: TextStyle(fontSize: 18, color: Colors.black45),
            )),
          ],
        ),
        onTap: () => showToast('잘 눌림'));
  }

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
          "    프로필",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Center(
          child: Image(
            image: AssetImage("assets/Img/userviewImg/strong.png"),
            width: 100,
            height: 100,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ]),
        SizedBox(
          height: 25,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                stuff("프로필 변경하기", Icons.person),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  indent: 10,
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 4,
                ),
                stuff('컬러 테마 설정', Icons.palette),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  indent: 10,
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 4,
                ),
                stuff('회원 탈퇴하기', Icons.palette),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "\n     쓰담쓰담 한마디\n",
                  style: TextStyle(color: Colors.black45),
                ),
                stuff('피드백 보내기', Icons.chat),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  indent: 10,
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 4,
                ),
                stuff('앱 평점주기 / 리뷰', Icons.thumb_up_alt),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "\n     득근이와 소통하기\n",
                  style: TextStyle(color: Colors.black45),
                ),
                stuff('카페 구경가기', Icons.local_cafe_rounded),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  indent: 10,
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 4,
                ),
                stuff('득근이 인스타그램', Icons.camera_alt_outlined),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  indent: 10,
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 4,
                ),
                stuff('개발자 소개', Icons.computer),
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseAuth.instance.signOut(),
        child: Icon(Icons.logout),
        tooltip: "로그아웃",
      ),
    );
  }
}
