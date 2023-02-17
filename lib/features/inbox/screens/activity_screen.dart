import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/rawData/inboxes.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/widgets/activities.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  bool _showBarrier = false;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  // Tween -> 애니메이션 컨트롤러에 이벤트리스너를 추가해 값을 수정하거나,
  //          애니메이션 빌더를 사용할 필요 없이 간단하고 직관적인 보간값을 적용하는 선형(linear) 애니메이션
  //          -> 애니메이션에 적용(별도 보간 state 불필요)
  late final Animation<double> _arrowAnimation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);

  late final Animation<Offset> _panelAnimation = Tween(
    // 위젯을 x, y 축에 얼마나 걸칠 것인가 결정 -> 주의! y축은 상하 반전값
    // Offset(0.0, 0.0) 원점 -> 위젯 왼쪽 위 꼭지점
    // Offset(1.0, 1.0) 원점 -> 위젯 오른쪽 아래 꼭지점
    // x, y 좌표값 1 -> 애니메이션이 적용된 위젯 너비, 높이와 같음
    begin: const Offset(0.0, -1), // 위로 완전히 감춤
    end: Offset.zero, // end: const Offset(0.0, 0.0),
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black.withOpacity(0.5),
  ).animate(_animationController);

  void _onDismissed(String notification) {
    notifications.remove(notification);
    setState(() {}); // 위젯 트리에 dismiss 반영
    // -> onDismissed 설정 없이 Dismissible 만 적용했을 때 뜬 플러터 에러가 해소된다.
  }

  // 부분 비동기 함수화 -> _showBarrier 투명도 변화 애니메이션 적용
  // 전부 동기처리로 놔둘 경우, setState()가 애니메이션 처리 이후 실행(애니메이션 시간 모두 종료된 시점)되므로
  //  배리어 등장 과정만 단순 깜빡임으로 보임
  //  -> 애니메이션 시간을 15초로 설정해두고 테스트해볼 것
  void _toggleAnimations() async {
    _animationController.isCompleted
        ? await _animationController.reverse() // 0.5 -> 0.0 // 비동기
        : _animationController.forward(); // 0.0 -> 0.5 // 동기

    // 배리어 등장은 애니메이션과 동기 실행(_animationController.forward() 기다렸다 실행),
    // 배리어 제거는 비동기 실행(_animationController.reverse() 기다리지 않고 실행)
    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(_notifications); // _onDismissed 결과 확인
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: _toggleAnimations,
            child: Row(
              mainAxisSize: MainAxisSize.min, // 제목 가운데 정렬을 위해 너비를 자식 위젯에 맞춘다.
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('All activity'),
                Gaps.h2,
                RotationTransition(
                  turns: _arrowAnimation, // 회전의 정도 -> 0: 0도, 1: 360도
                  child: const FaIcon(
                    FontAwesomeIcons.chevronDown,
                    size: Sizes.size14,
                  ),
                )
              ],
            ),
          ),
        ),
        body: Activities(
          onDismissed: _onDismissed,
          barrierAnimation: _barrierAnimation,
          panelAnimation: _panelAnimation,
          showBarrier: _showBarrier,
          toggleAnimations: _toggleAnimations,
        ));
  }
}
