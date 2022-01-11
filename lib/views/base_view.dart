import 'package:flutter/material.dart';
import 'package:gain_muscle/provider/page_provider.dart';
import 'package:gain_muscle/views/record_view.dart';
import 'package:gain_muscle/views/user_view.dart';
import 'package:provider/provider.dart';

import 'home_view.dart';
import 'item_view.dart';

class BaseView extends StatelessWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List _page = [homeView(), recordView(), itemView(), userView()];
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
            '득근득근',
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
