import 'package:flutter/material.dart';

class itemView extends StatefulWidget {
  const itemView({Key? key}) : super(key: key);

  @override
  _itemViewState createState() => _itemViewState();
}

class _itemViewState extends State<itemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('아이템, 칭호 관련 페이지'),
    );
  }
}
