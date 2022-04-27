import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gain_muscle/tmp/daily_record_view.dart';
import 'package:get/get.dart';

import '2_camera_view.dart';

class homeView extends StatefulWidget {
  const homeView({Key? key}) : super(key: key);

  @override
  _homeViewState createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  String userName = FirebaseAuth.instance.currentUser!.displayName as String;
  List<dynamic> routine = [];

  List<Color> colors = [
    Colors.lightBlue.shade50,
    Colors.lightBlue.shade100,
    Colors.lightBlue.shade200
  ];

  List<EdgeInsets> edge = [
    EdgeInsets.fromLTRB(0, 0, 20, 0),
    EdgeInsets.fromLTRB(0, 0, 0, 0),
    EdgeInsets.fromLTRB(0, 0, 40, 0)
  ];
  Future<void> getData() async {
    CollectionReference recordDB =
        FirebaseFirestore.instance.collection('user/$userName/record');
    print('데이터를 받아옵니다.');

    QuerySnapshot querySnapshot =
        await recordDB.orderBy('date', descending: true).limit(10).get();
    routine = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(routine);
  }

  final Future<List<CameraDescription>> cameras = availableCameras();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cameras,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              Get.to(() => DailyRecordView());
                            },
                            icon: Icon(Icons.search),
                            label: Text('운동 기록하기')),
                        Spacer(),
                        IconButton(
                            onPressed: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TakePictureScreen(
                                      cameras: snapshot.data
                                          as List<CameraDescription>),
                                ),
                              );
                            },
                            icon: Icon(Icons.camera_alt)),
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: getData(),
                      builder: (builder, contex) {
                        return Expanded(
                            child: Container(
                          width: MediaQuery.of(context).size.width,
                          // decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //         image: AssetImage(
                          //             'assets/Img/userviewImg/classic.jpg'),
                          //         fit: BoxFit.cover)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 40,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.redAccent),
                                  // borderRadius:
                                  //     BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Center(
                                  child: Text(
                                    '#User Title#',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://static.wikia.nocookie.net/pokemon/images/3/3a/%EC%95%8C%ED%86%B5%EB%AA%AC_%EA%B3%B5%EC%8B%9D_%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8.png/revision/latest?cb=20170405013322&path-prefix=ko'),
                                          fit: BoxFit.fill)),
                                  width: 150,
                                  height: 150,
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),
                              for (int i = 0; i < routine.length; i++)
                                Padding(
                                  padding: edge[i % 3],
                                  child: Container(
                                      height: 40,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          color: colors[i % 3],
                                          border:
                                              Border.all(color: colors[i % 3]),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Center(
                                        child: Text(
                                          '${routine[i]['volume']}KG',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )),
                                )
                            ],
                          ),
                        ));
                      })
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Container();
          }
          return CircularProgressIndicator();
        });
  }
}
