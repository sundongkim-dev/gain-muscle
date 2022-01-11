import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gain_muscle/views/camera_view.dart';
import 'package:gain_muscle/views/daily_record_view.dart';
import 'package:get/get.dart';

class homeView extends StatefulWidget {
  const homeView({Key? key}) : super(key: key);

  @override
  _homeViewState createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  final Future<List<CameraDescription>> cameras = availableCameras();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cameras,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: TextButton.icon(
                            onPressed: () {
                              Get.to(() => DailyRecordView());
                            },
                            icon: Icon(Icons.search),
                            label: Text('운동 기록하기')),
                      ),
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
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      color: Color.fromRGBO(155, 203, 172, 1),
                      child: Text('나중에 그림 들어갈 공간'),
                    ),
                  )
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
