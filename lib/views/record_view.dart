import 'package:flutter/material.dart';

class recordView extends StatefulWidget {
  const recordView({Key? key}) : super(key: key);

  @override
  _recordViewState createState() => _recordViewState();
}

class _recordViewState extends State<recordView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('운동 기록 보여주는 페이지'),
    );
  }
}
