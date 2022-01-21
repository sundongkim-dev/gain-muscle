import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:gallery_saver/files.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

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