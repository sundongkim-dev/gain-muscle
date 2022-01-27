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
        exerciseStuff('덤벨 런지'),
        exerciseStuff('스모 데드리프트'),
        exerciseStuff('스탠딩 카프 레이즈'),
        exerciseStuff('이너 싸이 머신'),
        exerciseStuff('에어 스쿼트'),
        exerciseStuff('런지'),
        exerciseStuff('점프 스쿼트'),
        exerciseStuff('저처 스쿼트'),
        exerciseStuff('바벨 스플릿 스쿼트'),
        exerciseStuff('스텝업'),
        exerciseStuff('중량 스텝업'),
        exerciseStuff('고블릿 스쿼트'),
        exerciseStuff('중량 힙 쓰러스트'),
        exerciseStuff('덤벨 스플릿 스쿼트'),
        exerciseStuff('힙 쓰러스트'),
        exerciseStuff('덤벨 불가리안 스플릿 스쿼트'),
        exerciseStuff('맨몸 스플릿 스쿼트'),
        exerciseStuff('케틀벨 고블릿 스쿼트'),
        exerciseStuff('브이 스쿼트'),
        exerciseStuff('리버스 브이 스쿼트'),
        exerciseStuff('힙 어브덕션 머신'),
        exerciseStuff('케이블 힙 어브덕션'),
        exerciseStuff('글루트 킥백 머신'),
        exerciseStuff('스미스머신 스쿼트'),
        exerciseStuff('핵 스쿼트'),
        exerciseStuff('정지 백 스쿼트'),
        exerciseStuff('스미스머신 런지'),
        exerciseStuff('정지 스모 데드리프트'),
        exerciseStuff('스미스머신 데드리프트'),
        exerciseStuff('시티드 카프 레이즈'),
        exerciseStuff('트랩바 데드리프트'),
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
        exerciseStuff('덤벨 플라이'),
        exerciseStuff('케이블 크로스오버'),
        exerciseStuff('체스트 프레스 머신'),
        exerciseStuff('펙덱 플라이 머신'),
        exerciseStuff('푸시업'),
        exerciseStuff('인클라인 덤벨 플라이'),
        exerciseStuff('덤벨 풀오버'),
        exerciseStuff('인클라인 벤치프레스 머신'),
        exerciseStuff('중량 딥스'),
        exerciseStuff('중량 푸시업'),
        exerciseStuff('힌두 푸시업'),
        exerciseStuff('아처 푸시업'),
        exerciseStuff('시티드 딥스 머신'),
        exerciseStuff('로우 풀리 케이블 플라이'),
        exerciseStuff('스미스머신 벤치프레스'),
        exerciseStuff('스포토 벤치프레스'),
        exerciseStuff('스미스머신 인클라인 벤치프레스'),
        exerciseStuff('해머 벤치프레스'),
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
        exerciseStuff('친업'),
        exerciseStuff('백 익스텐션'),
        exerciseStuff('굿모닝 엑서사이즈'),
        exerciseStuff('시티드 케이블 로우'),
        exerciseStuff('루마니안 데드리프트'),
        exerciseStuff('원암 덤벨 로우'),
        exerciseStuff('중량 풀업'),
        exerciseStuff('인클라인 바벨 로우'),
        exerciseStuff('인버티드 로우'),
        exerciseStuff('바벨 풀오버'),
        exerciseStuff('백 익스텐션'),
        exerciseStuff('중량 하이퍼 익스텐션'),
        exerciseStuff('중량 친업'),
        exerciseStuff('인클라인 덤벨 로우'),
        exerciseStuff('티바 로우 머신'),
        exerciseStuff('맥그립 랫풀다운'),
        exerciseStuff('스미스머신 로우'),
        exerciseStuff('케이블 암 풀다운'),
        exerciseStuff('정지 바벨 로우'),
        exerciseStuff('패러럴그립 랫풀다운'),
        exerciseStuff('리버스그립 랫풀다운'),
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
        exerciseStuff('페이스 풀'),
        exerciseStuff('핸드스탠드 푸시업'),
        exerciseStuff('케이블 리버스 플라이'),
        exerciseStuff('바벨 업라이트 로우'),
        exerciseStuff('벤트오버 덤벨 레터럴 레이즈'),
        exerciseStuff('아놀드 덤벨 프레스'),
        exerciseStuff('숄더 프레스 머신'),
        exerciseStuff('이지바 업라이트 로우'),
        exerciseStuff('핸드스탠드'),
        exerciseStuff('푸시 프레스'),
        exerciseStuff('덤벨 업라이트 로우'),
        exerciseStuff('바벨 슈러그'),
        exerciseStuff('리어 델토이드 플라이 머신'),
        exerciseStuff('스미스머신 오버헤드 프레스'),
        exerciseStuff('케이블 레터럴 레이즈'),
        exerciseStuff('레터럴 레이즈 머신'),
        exerciseStuff('스미스머신 슈러그'),
        exerciseStuff('케이블 프론트 레이즈'),
      ],
    ),
    ListView(
      children: [
        exerciseStuff('트레드밀'),
        exerciseStuff('싸이클'),
        exerciseStuff('로잉머신'),
        exerciseStuff('바 머슬업'),
        exerciseStuff('링 머슬업'),
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
        exerciseStuff('케이블 푸시 다운'),
        exerciseStuff('클로즈그립 푸시업'),
        exerciseStuff('이지바 컬'),
        exerciseStuff('케이블 컬'),
        exerciseStuff('케이블 삼두 익스텐션'),
        exerciseStuff('시티드 덤벨 익스텐션'),
        exerciseStuff('스컬 크러셔'),
        exerciseStuff('바벨 리스트 컬'),
        exerciseStuff('클로즈 그립 벤치프레스'),
        exerciseStuff('이지바 리스트 컬'),
        exerciseStuff('라잉 트라이셉스 익스텐션'),
        exerciseStuff('덤벨 프리쳐 컬'),
        exerciseStuff('바벨 프리쳐 컬'),
        exerciseStuff('이지바 프리쳐 컬'),
        exerciseStuff('프리쳐 컬 머신'),
        exerciseStuff('암 컬 머신'),
        exerciseStuff('케이블 해머컬'),
        exerciseStuff('케이블 오버헤드 삼두 익스텐션'),
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
