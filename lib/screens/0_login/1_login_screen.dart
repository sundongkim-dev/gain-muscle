import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import '3_register_screen.dart';

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
  Future<UserCredential> signInWithNaver() async {
    final clientState = Uuid().v4();
    final url = Uri.https('nid.naver.com', '/oauth2.0/authorize', {
      'response_type': 'code',
      'client_id': 'VGBc1i97dIW8vg_WGbSG',
      'redirect_uri': 'https://gainmuscle.herokuapp.com/callbacks/naver/sign_in',
      'state': clientState,
    });
    final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: "webauthcallback"
    );
    final body = Uri.parse(result).queryParameters;
    print(body["code"]);

    final tokenUrl = Uri.https('nid.naver.com', '/oauth2.0/token', {
      'grant_type': 'authorization_code',
      'client_id': "VGBc1i97dIW8vg_WGbSG",
      'client_secret': "CQw8KoCA4N",
      'code': body["code"],
      'state': clientState,
    });
    var responseTokens = await http.post(tokenUrl);
    Map<String, dynamic> bodys = json.decode(responseTokens.body);
    var response = await http.post(
        Uri.parse("https://gainmuscle.herokuapp.com/callbacks/naver/token"),
        body: {"accessToken": bodys['access_token']}
    );
    return FirebaseAuth.instance.signInWithCustomToken(response.body);
  }

  Future<UserCredential> signInWithKakao() async {
    final clientState = Uuid().v4();
    final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
      'response_type': 'code',
      'client_id': 'c2d358c9b44921bce63cdd0bdc042652',
      'redirect_uri': 'https://gainmuscle.herokuapp.com/callbacks/kakao/sign_in',
      'state': clientState,
    });
    final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: "webauthcallback"
    );
    final body = Uri.parse(result).queryParameters;
    print(body["code"]);

    final tokenUrl = Uri.https('kauth.kakao.com', '/oauth/token', {
      'grant_type': 'authorization_code',
      'client_id': "c2d358c9b44921bce63cdd0bdc042652",
      'redirect_uri': 'https://gainmuscle.herokuapp.com/callbacks/kakao/sign_in',
      'code': body["code"],
    });
    var responseTokens = await http.post(tokenUrl);
    Map<String, dynamic> bodys = json.decode(responseTokens.body);
    var response = await http.post(
        Uri.parse("https://gainmuscle.herokuapp.com/callbacks/kakao/token"),
        body: {"accessToken": bodys['access_token']});
    return FirebaseAuth.instance.signInWithCustomToken(response.body);
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