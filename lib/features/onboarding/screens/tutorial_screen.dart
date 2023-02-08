import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/enums/direction.dart';
import 'package:tiktok_clone/constants/enums/showing_page.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/onboarding/widgets/tutorial.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;

  ShowingPage _showingPage = ShowingPage.first;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _direction = details.delta.dx > 0 ? Direction.right : Direction.left;
    });
    // 드래그 동작 시 오프셋 변화 확인 테스트 -> cf. Offset delta
    // 오프셋 x좌표(details.delta.dx): 좌로 드래그 => 음수 | 우로 드래그 => 양수
    // 오프셋 y좌표(details.delta.dy): 위로 드래그 => 음수 | 아래로 드래그 => 양수
    print(details);
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _showingPage =
          _direction == Direction.left ? ShowingPage.second : ShowingPage.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    // DefaultTabController -> TabBarView, TabPageSelector 컨트롤러 일괄 설정
    // return const TabBarEx();
    return GestureDetector(
      onPanUpdate: _onPanUpdate, // 드래그
      onPanEnd: _onPanEnd, // 드롭,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            // 둘 이상의 위젯을 전환할 경우, AnimatedSwitcher 권장 => 플러터 '금주의 위젯' 동영상 참고
            child: AnimatedCrossFade(
              firstChild: const Tutorial(
                  mainText: 'Watch cool videos!',
                  subText:
                      'Videos are personalized for you based on what you watch, like, and share.'),
              secondChild: const Tutorial(
                mainText: 'Follow the rules!',
                subText: 'Take care of one another! please.',
              ),
              // crossFadeState: CrossFadeState.showFirst,
              crossFadeState: _showingPage == ShowingPage.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size24,
              horizontal: 24,
            ),
            child: AnimatedOpacity(
              opacity: _showingPage == ShowingPage.first ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: CupertinoButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: const Text('Enter the app!'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
