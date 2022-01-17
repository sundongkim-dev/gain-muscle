import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gain_muscle/src/pages/developerInfo.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

User? user = FirebaseAuth.instance.currentUser;

class userView extends StatefulWidget {
  const userView({Key? key}) : super(key: key);

  @override
  _userViewState createState() => _userViewState();
}

class _userViewState extends State<userView> {
  String name = FirebaseAuth.instance.currentUser!.displayName as String;

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

  InkWell stuff(String name, IconData icon, Widget widget) {
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
        onTap: () => {Get.to(widget)});
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
                stuff("프로필 변경하기", Icons.person, developerInfo()),
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
                stuff('컬러 테마 설정', Icons.palette, developerInfo()),
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
                InkWell(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.elderly,
                          color: Colors.black45,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child:
                        Text(
                          "회원 탈퇴하기", style: TextStyle(fontSize: 18, color: Colors.black45),
                        )),
                      ],
                    ),
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => deleteUser()));
                    }
                ),
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
                InkWell(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.logout,
                          color: Colors.black45,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child:
                        Text(
                          "로그아웃 하기", style: TextStyle(fontSize: 18, color: Colors.black45),
                        )),
                      ],
                    ),
                    onTap: () => FirebaseAuth.instance.signOut(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "\n     쓰담쓰담 한마디\n",
                  style: TextStyle(color: Colors.black45),
                ),
                InkWell(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.chat,
                          color: Colors.black45,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child:
                        Text(
                          "피드백 보내기", style: TextStyle(fontSize: 18, color: Colors.black45),
                        )),
                      ],
                    ),
                    onTap: () async {
                      final Uri params = Uri(
                        scheme: 'mailto',
                        path: 'mok03127@gmail.com',
                        //query:
                      );
                      String url = params.toString();
                      if(await canLaunch(url)) {
                        await launch(url);
                      } else {
                        print("Can't launch $url");
                      }
                    }
                ),
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
                stuff('앱 평점주기 / 리뷰', Icons.thumb_up_alt, developerInfo()),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "\n     득근이와 소통하기\n",
                  style: TextStyle(color: Colors.black45),
                ),
                InkWell(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.local_cafe_rounded,
                          color: Colors.black45,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child:
                        Text(
                          "카페 구경가기", style: TextStyle(fontSize: 18, color: Colors.black45),
                        )),
                      ],
                    ),
                    onTap: () async {
                      const url = 'https://cafe.naver.com/gainmuscle';
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                          forceWebView: false,
                          enableJavaScript: true,
                        );
                      }
                      else {
                        print("!!!");
                      }
                    }
                ),
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
                InkWell(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black45,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child:
                        Text(
                          "득근이 인스타그램", style: TextStyle(fontSize: 18, color: Colors.black45),
                        )),
                      ],
                    ),
                    onTap: () async {
                      const url = 'https://www.instagram.com/gain._.muscle';
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                          forceWebView: false,
                          enableJavaScript: true,
                        );
                      }
                      else {
                        print("!!!");
                      }
                    }
                ),
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
                stuff('개발자 소개', Icons.computer, developerInfo()),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class deleteUser extends StatelessWidget {
  const deleteUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("득근득근 회원 탈퇴"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("정말 탈퇴하시겠어요?\n탈퇴 과정엔 계정에 따라 재인증이 필요하며 탈퇴 후엔 그동안의 기록들을 절대로 복구할 수 없습니다!"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          child: Text("취소"),
        ),
        TextButton(
          onPressed: () async {
            try{
              User user = await FirebaseAuth.instance.currentUser!;
              user.delete();
            } on FirebaseAuthException catch (e){
              print(e);
            }
            Navigator.pop(context);
          },
          child: Text("확인"),),
      ],
    );
  }
}
