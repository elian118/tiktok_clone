import 'package:flutter/cupertino.dart';

// InheritedWidget -> 모든 위젯에서 참조만 가능할 뿐, 필드 정보 업데이트 불가(단순 데이터 전달자에 불과)
//  -> 업데이트하려면, setState 사용 가능한 StatefulWidget 과 연동해서 써야 함
class VideoConfigData extends InheritedWidget {
  final bool autoMute;
  final void Function({bool? isMute}) toggleMuted;

  const VideoConfigData({
    super.key,
    required this.autoMute,
    required this.toggleMuted,
    required super.child,
  });

  // 상속된 위젯(InheritedWidget) 정보를 외부로 전달
  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
  }

  // 상속된 위젯 업데이트에 따른 리빌드 여부
  // => 여기서는 딱히 쓸 일이 없으나, 필수 구현 추상 메서드라 일단, return true 로 오버라이드
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

// InheritedWidget 데이터 변경을 위한 StatefulWidget
class VideoConfig extends StatefulWidget {
  final Widget child;
  const VideoConfig({Key? key, required this.child}) : super(key: key);

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfig> {
  bool autoMute = true;

  void toggleMuted({bool? isMute}) {
    autoMute = isMute ?? !autoMute;
    setState(() {});
  }

  // VideoConfigData.of(context).toggleMuted() -> setState() -> 리빌드
  //  -> autoMute 업데이트 된 VideoConfigData 위젯으로 교체
  //  -> 변경된 VideoConfigData.of(context).autoMute 값이 침조됨
  @override
  Widget build(BuildContext context) {
    return VideoConfigData(
        toggleMuted: toggleMuted, autoMute: autoMute, child: widget.child);
  }
}
