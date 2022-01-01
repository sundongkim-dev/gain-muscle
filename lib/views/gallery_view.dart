import 'dart:io';

import 'package:flutter/material.dart';

class galleryView extends StatelessWidget {
  const galleryView({Key? key, required this.images}) : super(key: key);

  final List<File> images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: images
            .map((image) => Image.file(image, fit: BoxFit.cover))
            .toList(),
      ),
    );
  }
}
