import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/enums/breakpoints.dart';
import 'package:tiktok_clone/common/constants/enums/direction.dart';
import 'package:tiktok_clone/common/constants/enums/showing_page.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/screens/main_navigation_screen.dart';
import 'package:tiktok_clone/features/onboarding/widgets/tutorial.dart';
import 'package:tiktok_clone/utils/utils.dart';

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
    _showingPage =
        _direction == Direction.left ? ShowingPage.second : ShowingPage.first;
    setState(() {});
  }

  void _onPressArrow(Direction direction) {
    _showingPage =
        direction == Direction.left ? ShowingPage.second : ShowingPage.first;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // DefaultTabController -> TabBarView, TabPageSelector 컨트롤러 일괄 설정
    // return const TabBarEx();
    final isWebScreen = MediaQuery.of(context).size.width > Breakpoint.lg;
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
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
            top: Sizes.size32,
            bottom: Sizes.size32,
            left: isWebScreen ? 275 : Sizes.size24,
            right: isWebScreen ? 275 : Sizes.size24,
          ),
          color: isDarkMode(context) ? Colors.black : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size24,
              horizontal: 24,
            ),
            child: AnimatedOpacity(
              opacity:
                  _showingPage == ShowingPage.first && !isWebScreen ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: Row(
                mainAxisAlignment: isWebScreen
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  if (isWebScreen)
                    AnimatedOpacity(
                      opacity: _showingPage == ShowingPage.first ? 0 : 1,
                      duration: const Duration(milliseconds: 300),
                      child: IconButton(
                        onPressed: () => _onPressArrow(Direction.right),
                        icon: const FaIcon(FontAwesomeIcons.chevronLeft),
                      ),
                    ),
                  CupertinoButton(
                    onPressed: () =>
                        _showingPage == ShowingPage.first && isWebScreen
                            ? _onPressArrow(Direction.left)
                            : navPushAndRemoveUntil(context,
                                const MainNavigationScreen(), (route) => false),
                    color: Theme.of(context).primaryColor,
                    child: Text(_showingPage == ShowingPage.first && isWebScreen
                        ? 'Next'
                        : 'Enter the app!'),
                  ),
                  if (isWebScreen)
                    AnimatedOpacity(
                      opacity: _showingPage == ShowingPage.first ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: IconButton(
                        onPressed: () => _onPressArrow(Direction.left),
                        icon: const FaIcon(FontAwesomeIcons.chevronRight),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
