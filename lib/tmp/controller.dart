import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var isTodayRest = false;

  var index = 0;

  List<dynamic> exerciseBasket = [];

  List<Widget> exerciseList = [
    ListView(
      children: [
        exerciseStuff('바벨 백스쿼트'),
        exerciseStuff('컨벤셔널 데드리프트'),
        exerciseStuff('프론트 스쿼트'),
        exerciseStuff('레그 프레스'),
        exerciseStuff('레그 컬'),
        exerciseStuff('레그 익스텐션'),
      ],
    ),
    ListView(
      children: [
        exerciseStuff('벤치프레스'),
        exerciseStuff('인클라인 벤치프레스'),
        exerciseStuff('덤벨 벤치프레스'),
        exerciseStuff('덤벨 벤치프레스'),
        exerciseStuff('인클라인 덤벨 벤치프레스'),
        exerciseStuff('딥스'),
      ],
    ),
    ListView(
      children: [
        exerciseStuff('풀업'),
        exerciseStuff('바벨 로우'),
        exerciseStuff('덤벨 로우'),
        exerciseStuff('펜들레이 로우'),
        exerciseStuff('시티드 로우 머신'),
        exerciseStuff('렛풀다운'),
      ],
    ),
    ListView(
      children: [
        exerciseStuff('오버헤드 프레스'),
        exerciseStuff('덤벨 숄더 프레스'),
        exerciseStuff('덤벨 레터럴 레이즈'),
        exerciseStuff('덤벨 프론트 레이즈'),
        exerciseStuff('덤벨 슈러그'),
        exerciseStuff('비하인드 넥 프레스'),
      ],
    ),
    ListView(
      children: [
        exerciseStuff('달리기'),
        exerciseStuff('싸이클'),
        exerciseStuff('로잉머신'),
      ],
    ),
    ListView(
      children: [
        exerciseStuff('바벨 컬'),
        exerciseStuff('덤벨 컬'),
        exerciseStuff('덤벨 삼두 익스텐션'),
        exerciseStuff('덤벨 킥백'),
        exerciseStuff('덤벨 리스트 컬'),
        exerciseStuff('덤벨 해머 컬'),
      ],
    ),
  ];

  exerciseTapped(int idx) {
    index = idx;
    print('종목 변경');
    update();
  }

  rest() {
    isTodayRest = true;
    print('휴식');
    update();
  }

  cancel() {
    isTodayRest = false;
    print('휴식취소');
    update();
  }

  addToBasket(String name) {
    exerciseBasket.add(name);
    update();
  }

  removeFromBasket(String name) {
    exerciseBasket.remove(name);
    update();
  }
}

TextButton exerciseStuff(String name) {
  // return GestureDetector(
  //   onTap: () {
  //     if (Get.find<Controller>().exerciseBasket.contains(name)) {
  //       Get.find<Controller>().removeFromBasket(name);
  //     } else {
  //       Get.find<Controller>().addToBasket(name);
  //     }
  //     print("잘 눌림");
  //   },
  //   child: Padding(
  //     padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
  //     child: Row(
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
  //           child: Image.asset(
  //             'assets/Img/userviewImg/strong.png',
  //             width: 40,
  //             height: 40,
  //           ),
  //         ),
  //         Expanded(
  //           child: Padding(
  //             padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
  //             child: Text(
  //               name,
  //               style: TextStyle(
  //                   backgroundColor:
  //                       false ? Colors.blue.shade300 : Colors.white,
  //                   color: false ? Colors.white : Colors.black),
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
  //           child: Icon(Icons.favorite),
  //         ),
  //       ],
  //     ),
  //   ),
  // );

  return TextButton(
      onPressed: () {
        if (Get.find<Controller>().exerciseBasket.contains(name)) {
          Get.find<Controller>().removeFromBasket(name);
        } else {
          Get.find<Controller>().addToBasket(name);
        }
        print("잘 눌림");
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Container(
          color: false ? Colors.blue.shade300 : Colors.white,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Image.asset(
                  'assets/Img/userviewImg/strong.png',
                  width: 40,
                  height: 40,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    name,
                    style: TextStyle(
                        backgroundColor:
                            false ? Colors.blue.shade300 : Colors.white,
                        color: false ? Colors.white : Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ));
}

Padding partStuff(String name) {
  bool tapped = false;
  return Padding(
    padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
    child: OutlinedButton(
      onPressed: null,
      child: Text(
        name,
        // style: TextStyle(color: Colors.black),
      ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.black),
        side: MaterialStateProperty.all(BorderSide(color: Colors.black)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
        ),
      ),
    ),
  );
}
