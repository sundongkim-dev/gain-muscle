import 'package:flutter/material.dart';

class userView extends StatefulWidget {
  const userView({Key? key}) : super(key: key);

  @override
  _userViewState createState() => _userViewState();
}

class _userViewState extends State<userView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('사용자 설정 페이지'),
    );
  }
}
