import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class developerInfo extends StatelessWidget {
  const developerInfo({Key? key}) : super(key: key);

  void redirectInstaURL(String url) async {
    if(await canLaunch(url)) {
      await launch(
        url,
        forceWebView: false,
        forceSafariVC: false,
        enableJavaScript: true,
      );
    }
    else{
      print("!!!");
    }
  }

  void redirectEmailURL(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    String url = params.toString();
    if(await canLaunch(url)){
      await launch(url);
    } else {
      print("Can't launch $url");
    }
  }

  InkWell contactInfoWidget(String type, String txt, String url, Function func) {
    return InkWell(
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
                child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type, style: TextStyle(fontSize: 14, color: Colors.redAccent),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        txt, style: TextStyle(fontSize: 14, color: Colors.black87),
                      )
                    ],
                  )
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        onTap: () async {
          func(url);
        }
    );
  }

  InkWell developerInfoWidget(String photo, String developerType, String txt, String txt2, String url, Function func) {
    return InkWell(
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              child: Image(
                image: AssetImage(photo),
                width: 100,
                height: 100,
              ),
            ),
            Expanded(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      developerType, style: TextStyle(fontSize: 14, color: Colors.redAccent),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      txt, style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      txt2, style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                )
            ),
          ],
        ),
        onTap: () async {
          func(url);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: () { Get.back(); },),
        title: Text("개발자 소개", style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
              image: AssetImage("assets/Img/userviewImg/strong.png"),
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              contactInfoWidget("Instagram", "@gain._.muscle", "https://www.instagram.com/gain._.muscle", redirectInstaURL),
              SizedBox(
              height: 15,
              ),
              contactInfoWidget("Contact", "mok03127@gmail.com", "mok03127@gmail.com", redirectEmailURL),
              SizedBox(
                height: 10,
              ),
              Divider(
                indent: 10,
                endIndent: 20,
                thickness: 1.5,
              ),
              developerInfoWidget("assets/Img/userviewImg/strong.png", "IOS Developer", "Paul_Kim", "sundongkim-dev", 'https://github.com/sundongkim-dev', redirectInstaURL),
              SizedBox(
                height: 10,
              ),
              Divider(
                indent: 10,
                endIndent: 20,
                thickness: 1.5,
              ),
              developerInfoWidget("assets/Img/userviewImg/strong.png", "Android Developer", "Paul_Kim", "sundongkim-dev", 'https://github.com/sundongkim-dev', redirectInstaURL),
              SizedBox(
                height: 10,
              ),
              Divider(
                indent: 10,
                endIndent: 20,
                thickness: 1.5,
              ),
              developerInfoWidget("assets/Img/userviewImg/strong.png", "코딩의 신", "박찬돌", "chandroid", 'https://github.com/sundongkim-dev', redirectInstaURL),
            ],
          ),
        ],
      ),
    );
  }
}
