import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gain_muscle/provider/page_provider.dart';
import 'package:gain_muscle/views/record_view.dart';
import 'package:gain_muscle/views/user_view.dart';
import 'package:provider/provider.dart';

import 'home_view.dart';
import 'item_view.dart';

class BaseView extends StatelessWidget {
  const BaseView({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;
  @override
  Widget build(BuildContext context) {
    final List _page = [
      homeView(cameras: cameras),
      recordView(),
      itemView(),
      userView()
    ];
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    print('basicstructure');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff84ffff),
          leading: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          title: Text(
            '넌 이미 운동을 하고 있다',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: _page[pageProvider.idx],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          onTap: pageProvider.changePage,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(
                icon: Icon(Icons.audiotrack), label: '운동기록'),
            BottomNavigationBarItem(
                icon: Icon(Icons.beach_access), label: '아이템,칭호'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '사용자계정'),
          ],
        ));
  }
}
