import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyRecordView extends StatefulWidget {
  const DailyRecordView({Key? key}) : super(key: key);

  @override
  _DailyRecordViewState createState() => _DailyRecordViewState();
}

class _DailyRecordViewState extends State<DailyRecordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 운동을 기록해주세요!'),
      ),
      body: Container(),
    );
  }
}
