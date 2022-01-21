import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:gain_muscle/src/pages/register.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

import 'loginFunc.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  void signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider
        .credential(loginResult.accessToken!.token);
    try {
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        print('The account already exists for that email.');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>
            AlertDialog(
              title: Text('에러'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("The account already exists for that email."),
                    Text("다시 설정하세요."),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text("확인"),),
                TextButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text("취소"),),
              ],
            ))
        );
      }
    }
  }

  void signInWithEmail() async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found'){
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Form(
            key: formKey,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "  로그인",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: Image(
                          image: AssetImage("assets/Img/loginImages/muscle.png"),
                        ),
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const Text(
                          "환영합니다 :)\n득근득근 입니다!",
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        onSaved: (value) => _emailController.text = value!.trim(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "이메일",
                        ),
                      ),
                      TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        onSaved: (value) => _passwordController.text = value!.trim(),
                        obscureText: true,
                        autocorrect: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: "비밀번호",
                        ),
                      ),
                      // Spacer(),
                      Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        child: SignInButtonBuilder(
                          backgroundColor: Colors.redAccent,
                          onPressed: () {
                            signInWithEmail();
                          },
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
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          const Text(
                            "다음 계정으로 로그인",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
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
                                  onPressed: () {
                                    signInWithFacebook();
                                    //linkGoogleAndFacebook();
                                  }
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: SignInButton(
                                    Buttons.Google,
                                    text: "Google",
                                    onPressed: () {
                                      signInWithGoogle();
                                      //linkGoogleAndFacebook();
                                    }
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: SignInButton(
                                Buttons.Facebook,
                                text: "Kakao",
                                onPressed: signInWithKakao, //signInWithKakao,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: SignInButton(
                                  Buttons.Google,
                                  text: "Naver",
                                  onPressed: signInWithNaver,
                                )),
                          ],
                        ),
                      ),
                      // Spacer(),
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
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterWidget()),
                            ),
                            child: const Text(
                              "회원가입",
                              style: TextStyle(color: Colors.black),
                            )),
                      ]),
                    ],
                  ),
                )
              ],
            )));
  }
}