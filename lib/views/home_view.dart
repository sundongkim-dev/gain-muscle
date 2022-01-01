import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gain_muscle/views/camera_view.dart';

class homeView extends StatefulWidget {
  const homeView({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;
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
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.search),
                    Text('운동 기록하기'),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            TakePictureScreen(cameras: widget.cameras),
                      ),
                    );
                  },
                  icon: Icon(Icons.camera_alt)),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //   // color: const Color(0xff7c94b6),
              //   image: DecorationImage(
              //       image: AssetImage('assets/Img/splashImg/splashImg.png')),
              // ),
              color: Color.fromRGBO(155, 203, 172, 1),
              child: Text('나중에 그림 들어갈 공간'),
            ),
          )
        ],
      ),
    );
  }
}
