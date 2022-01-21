import 'package:get/get.dart';

class Controller extends GetxController {
  var isTodayRest = false;

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
}
