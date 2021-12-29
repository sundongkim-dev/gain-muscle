import 'package:flutter/material.dart';

class homeView extends StatefulWidget {
  const homeView({Key? key}) : super(key: key);

  @override
  _homeViewState createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search),
              Text('운동 기록하기'),
              Icon(Icons.camera_alt),
            ],
          ),
          Container(
            alignment: Alignment.center,
            // decoration: BoxDecoration(
            //   // color: const Color(0xff7c94b6),
            //   image: DecorationImage(
            //       image: AssetImage('assets/Img/splashImg/splashImg.png')),
            // ),
            color: Color.fromRGBO(123, 12, 232, 1),
            child: Text('나중에 그림 들어갈 공간'),
          ),
        ],
      ),
    );
  }
}
