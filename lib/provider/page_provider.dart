import 'package:flutter/cupertino.dart';

// 페이지를 바꿔주는 idx를 provider로 구현.
class PageProvider extends ChangeNotifier {
  int _idx = 0;

  int get idx => _idx;

  void changePage(int idx) {
    _idx = idx;
    notifyListeners();
  }
}
