import 'package:flutter/cupertino.dart';

class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoplay = false;

  void toggleMute() {
    isMuted = !isMuted; // build() 안에서 작동하는 게 아니므로, setState 불필요
    notifyListeners(); // 대신, 데이터가 변경됐음을 알리는 리스너를 꼭 붙여야 한다.
  }

  void toggleAutoPlay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}
