import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class developerInfo extends StatelessWidget {
  const developerInfo({Key? key}) : super(key: key);

  InkWell stuff(String name, IconData icon, Widget widget) {
    return InkWell(
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              color: Colors.black45,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                )),
          ],
        ),
        onTap: () => {Get.to(widget)});
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
              InkWell(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Instagram", style: TextStyle(fontSize: 14, color: Colors.redAccent),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "@gain._.muscle", style: TextStyle(fontSize: 14, color: Colors.black87),
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
                  final url = 'https://www.instagram.com/gain._.muscle';
                  if (await canLaunch(url)) {
                    await launch(
                      url,
                      forceSafariVC: false,
                      forceWebView: false,
                      enableJavaScript: true,
                    );
                  }
                  else {
                    print("!!!");
                  }
                }
              ),
              SizedBox(
              height: 15,
              ),
              InkWell(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact", style: TextStyle(fontSize: 14, color: Colors.redAccent),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "mok03127@gmail.com", style: TextStyle(fontSize: 14, color: Colors.black87),
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
                    final Uri params = Uri(
                      scheme: 'mailto',
                      path: 'mok03127@gmail.com',
                      //query:
                    );
                    String url = params.toString();
                    if(await canLaunch(url)) {
                      await launch(url);
                    } else {
                      print("Can't launch $url");
                    }
                  }
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
              indent: 10,
              endIndent: 20,
              thickness: 1.5,
              ),
              InkWell(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Image(
                          image: AssetImage("assets/Img/userviewImg/strong.png"),
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
                                  "IOS Developer", style: TextStyle(fontSize: 14, color: Colors.redAccent),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "당신은 과연 누구..? 김선동..?\n 박찬돌..? 최형진..?", style: TextStyle(fontSize: 14, color: Colors.black87),
                                )
                              ],
                            )
                      ),
                    ],
                  ),
                  onTap: () async {
                    final url = 'https://github.com/sundongkim-dev';
                    if (await canLaunch(url)) {
                      await launch(
                        url,
                        forceSafariVC: false,
                        forceWebView: false,
                        enableJavaScript: true,
                      );
                    }
                    else {
                      print("!!!");
                    }
                  }
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                indent: 10,
                endIndent: 20,
                thickness: 1.5,
              ),
              InkWell(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Image(
                          image: AssetImage("assets/Img/userviewImg/strong.png"),
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
                                "Android Developer", style: TextStyle(fontSize: 14, color: Colors.redAccent),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Paul_Kim", style: TextStyle(fontSize: 14, color: Colors.black87),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "sundongkim-dev", style: TextStyle(fontSize: 14, color: Colors.black87),
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                  onTap: () async {
                    final url = 'https://github.com/sundongkim-dev';
                    if (await canLaunch(url)) {
                      await launch(
                        url,
                        forceSafariVC: false,
                        forceWebView: false,
                        enableJavaScript: true,
                      );
                    }
                    else {
                      print("!!!");
                    }
                  }
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                indent: 10,
                endIndent: 20,
                thickness: 1.5,
              ),
              InkWell(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Image(
                          image: AssetImage("assets/Img/userviewImg/strong.png"),
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
                                "코딩의 신", style: TextStyle(fontSize: 14, color: Colors.redAccent),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "박찬돌", style: TextStyle(fontSize: 14, color: Colors.black87),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Chandroid", style: TextStyle(fontSize: 14, color: Colors.black87),
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                  onTap: () async {
                    final url = 'https://github.com/sundongkim-dev';
                    if (await canLaunch(url)) {
                      await launch(
                        url,
                        forceSafariVC: false,
                        forceWebView: false,
                        enableJavaScript: true,
                      );
                    }
                    else {
                      print("!!!");
                    }
                  }
              ),
            ],
          ),
        ],

      ),
    );
  }
}
