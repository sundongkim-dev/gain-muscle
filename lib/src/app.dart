import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gain_muscle/provider/page_provider.dart';
import 'package:gain_muscle/src/pages/home.dart';
import 'package:gain_muscle/views/home_view.dart';
import 'package:gain_muscle/views/item_view.dart';
import 'package:gain_muscle/views/record_view.dart';
import 'package:gain_muscle/views/user_view.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(), // firebase 연결
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // firebase 연결 실패
          return Center(
            child: Text("Firebase load fail"),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // firebase 연결 성공
          // return Home();
          return MaterialApp(
              // home: Image.asset('img/splashImg/splashImg.png')
              /*home: Center(
        child: Container(width:50, height:50, color:Colors.blue), // 사이즈 단위는 픽셀이 아닌 LP, 50LP == 1.2cm
      )*/
              home: ChangeNotifierProvider(
                  create: (context) => PageProvider(),
                  child: BasicStructure(cameras: cameras)));
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class BasicStructure extends StatelessWidget {
  const BasicStructure({Key? key, required this.cameras}) : super(key: key);

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
          title: Text('넌 이미 운동을 하고 있다'),
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
