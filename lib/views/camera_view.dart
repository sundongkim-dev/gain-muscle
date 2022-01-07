import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gain_muscle/views/gallery_view.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.cameras,
  }) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  int cameraIdx = 0;
  List<File> capturedImages = []; // 찍힌 사진 담아놓은 리스트

  @override
  void initState() {
    super.initState();
    initializeCamera(cameraIdx);
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  void initializeCamera(int idx) async {
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.cameras[cameraIdx],
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  void changeCamera() {
    setState(() {
      cameraIdx = cameraIdx == 0 ? 1 : 0;
      initializeCamera(cameraIdx);
    });
  }

  void takePhoto() async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final image = await _controller.takePicture();

      // If the picture was taken, display it on a new screen.
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(
            // Pass the automatically generated path to
            // the DisplayPictureScreen widget.
            imagePath: image.path,
          ),
        ),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '오늘의 운동샷 찍기',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xff84ffff),
        ),
        // You must wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner until the
        // controller has finished initializing.
        backgroundColor: Colors.black,
        body: Column(
          children: [
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return CameraPreview(_controller);
                } else {
                  // Otherwise, display a loading indicator.
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: changeCamera,
                  icon: Icon(
                    Icons.switch_camera_rounded,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  // 사진찍는 버튼
                  onTap: () async {
                    await _initializeControllerFuture;
                    var xFile = await _controller.takePicture();
                    setState(() {
                      capturedImages.add(File(xFile.path));
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  // 찍은 사진들 보여주는 버튼
                  onTap: () {
                    if (capturedImages.isEmpty) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => galleryView(
                                images: capturedImages.reversed.toList())));
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      image: capturedImages.isNotEmpty
                          ? DecorationImage(
                              image: FileImage(capturedImages.last),
                              fit: BoxFit.cover)
                          : null,
                    ),
                  ),
                ),
              ],
            )
          ],
        )
        // floatingActionButton: FloatingActionButton(
        //   // Provide an onPressed callback.
        //   onPressed: () async {
        //     // Take the Picture in a try / catch block. If anything goes wrong,
        //     // catch the error.
        //     try {
        //       // Ensure that the camera is initialized.
        //       await _initializeControllerFuture;

        //       // Attempt to take a picture and get the file `image`
        //       // where it was saved.
        //       final image = await _controller.takePicture();

        //       // If the picture was taken, display it on a new screen.
        //       await Navigator.of(context).push(
        //         MaterialPageRoute(
        //           builder: (context) => DisplayPictureScreen(
        //             // Pass the automatically generated path to
        //             // the DisplayPictureScreen widget.
        //             imagePath: image.path,
        //           ),
        //         ),
        //       );
        //     } catch (e) {
        //       // If an error occurs, log the error to the console.
        //       print(e);
        //     }
        //   },
        //   child: const Icon(Icons.camera_alt),
        // ),
        );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display the Picture'),
        backgroundColor: Color(0xff84ffff),
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
