import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:gain_muscle/src/pages/login_text.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        /*child:
            Image.asset("assets/Img/loginImages/muscle.png"),*/
        children: [
          const Text(
            "  로그인",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          // Image.asset("assets/Img/loginImages/muscle.png"),
          Center(
            child: Image(
              image: AssetImage("assets/Img/loginImages/muscle.png"),
            ),
          ),
          Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "환영합니다 :)\n득근득근 입니다!",
              textAlign: TextAlign.center,
            ),
          ]),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: "이메일",
            ),
          ),
          Spacer(),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: "비밀번호",
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: SignInButtonBuilder(
              backgroundColor: Colors.redAccent,
              onPressed: () {},
              text: "이메일로 로그인",
              icon: Icons.email,
              width: double.infinity,
              height: 50,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: null,
            child: Text(
              "비밀번호를 잊으셨나요?",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Spacer(),
          Row(
            children: [
              Expanded(child: Divider()),
              const Text(
                "다음 계정으로 로그인",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Divider()),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: SignInButton(
                    Buttons.Facebook,
                    text: "Facebook",
                    onPressed: signInWithFacebook,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: SignInButton(
                  Buttons.Google,
                  text: "Google",
                  onPressed: signInWithGoogle,
                )),
              ],
            ),
          ),
          Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "계정이 없으신가요?",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onPressed: null,
                child: const Text(
                  "회원가입",
                  style: TextStyle(color: Colors.black),
                )),
          ]),
        ],
      ),
    );
  }
}
