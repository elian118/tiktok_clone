import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/rawData/inboxes.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  // Tween -> 애니메이션 컨트롤러에 이벤트리스너를 추가해 값을 수정하거나,
  //          애니메이션 빌더를 사용할 필요 없이 간단하고 직관적인 보간값 적용
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

  void _onDismissed(String notification) {
    notifications.remove(notification);
    setState(() {}); // 위젯 트리에 dismiss 반영
    // -> onDismissed 설정 없이 Dismissible 만 적용했을 때 뜬 플러터 에러가 해소된다.
  }

  void _onTitleTab() {
    _animationController.isCompleted
        ? _animationController.reverse()
        : _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // print(_notifications); // _onDismissed 결과 확인
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onTitleTab,
          child: Row(
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
      body: Stack(
        children: [
          ListView(
            // padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
                child: Text(
                  'New',
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Gaps.v14,
              for (var notification in notifications)
                // Dismissible -> 자식을 옆으로 밀어 제거할 수 있는 기능 간단 적용
                Dismissible(
                  key: Key(notification),
                  onDismissed: (direction) => _onDismissed(notification),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.green,
                    child: const Padding(
                      padding: EdgeInsets.only(left: Sizes.size10),
                      child: FaIcon(
                        FontAwesomeIcons.checkDouble,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(right: Sizes.size10),
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: Sizes.size16,
                    // contentPadding: EdgeInsets.zero, // 콘텐츠 패딩 제거
                    leading: Container(
                      width: Sizes.size52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: Sizes.size1,
                        ),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: "Accounts updates:",
                        // RichText 기본 스타일
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: Sizes.size16,
                        ),
                        children: [
                          const TextSpan(
                            text: ' Upload longer videos',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: ' $notification',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: Sizes.size16,
                    ),
                  ),
                ),
            ],
          ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size4),
                  bottomRight: Radius.circular(Sizes.size4),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in tabs)
                    ListTile(
                      title: Row(
                        children: [
                          FaIcon(
                            tab['icon'],
                            color: Colors.black,
                            size: Sizes.size16,
                          ),
                          Gaps.h20,
                          Text(
                            tab['title'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Gaps.v16,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
