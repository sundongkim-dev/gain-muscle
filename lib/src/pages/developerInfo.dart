import 'package:flutter/material.dart';

class developerInfo extends StatelessWidget {
  const developerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: () { Navigator.pop(context); },),
        title: Text("개발자 소개", style: TextStyle(color: Colors.black)),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
              image: AssetImage("assets/Img/userviewImg/strong.png"),
              width: 200,
              height: 200,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text("Instagram")
              ),
            ],
          )
        ],
      )
    );
  }
}
