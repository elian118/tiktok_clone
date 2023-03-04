import 'package:flutter/cupertino.dart';

class VideoConfig extends InheritedWidget {
  const VideoConfig({super.key, required super.child});

  final bool autoMute = false;

  // 상속된 위젯(InheritedWidget) 정보를 외부로 전달
  static VideoConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfig>()!;
  }

  // 상속된 위젯 업데이트에 따른 리빌드 여부
  // => 여기서는 딱히 쓸 일이 없으나, 필수 구현 추상 메서드라 일단, return true 로 오버라이드
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
