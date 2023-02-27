import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/rawData/discovers.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/web_container.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/custom_navigaton.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/utils/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 3;
  bool _isVideoButtonHovered = false;

  void _onLongPressUp() {
    setState(() {
      _isVideoButtonHovered = false;
    });
  }

  void _onLongPressDown(LongPressDownDetails details) {
    setState(() {
      _isVideoButtonHovered = true;
    });
  }

  void _onHover() {
    setState(() {
      _isVideoButtonHovered = !_isVideoButtonHovered;
    });
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _videoPost() => navPush(
        context,
        Scaffold(
          appBar: AppBar(
            title: const Text('Record video'),
          ),
        ),
        true,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar, bottomSheet 등장으로
      // 다른 위젯에 있던 이미지나 영상의 fit 을 그대로 유지(기본설정)하는 설정 제거
      // 기본(true)일 경우, bottomNavigationBar 를 열었을 때 영상이 위아래로 찌그러진다.
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      // 네비게이션 선택(_selectedIndex 변경)에 따른 body 랜더링은 개발 목적에 따라, 아래 둘 중 하나 선택
      // 1) 새로 빌드하고 기존 위젯은 제거하는 방식 -> 기존 위젯 state 초기화
      //    body: screens.elementAt(_selectedIndex), // screens[_selectedIndex],
      // 2) 새로 빌드하되, 기존 위젯은 잠시 화면에서 감추는 방식 -> 기존 위젯 state 유지
      //    즉, 현재 스크롤 위치, 입력중이던 텍스트 등 유지 가능 -> 단, OffStage() 늘수록 메모리 부담 증가
      body: isWebScreen(context)
          ? Row(
              children: [
                NavigationRail(
                  backgroundColor:
                      _selectedIndex == 0 ? Colors.black : Colors.white,
                  labelType: NavigationRailLabelType.selected,
                  selectedIconTheme:
                      IconThemeData(color: Theme.of(context).primaryColor),
                  unselectedIconTheme: IconThemeData(
                    color: _selectedIndex == 0
                        ? Colors.grey.shade200
                        : Colors.grey.shade600,
                  ),
                  indicatorColor: Theme.of(context).primaryColor,
                  selectedLabelTextStyle:
                      TextStyle(color: Theme.of(context).primaryColor),
                  unselectedLabelTextStyle: TextStyle(
                    color: _selectedIndex == 0
                        ? Colors.grey.shade200
                        : Colors.grey.shade600,
                  ),
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onTap,
                  trailing: Padding(
                    padding: const EdgeInsets.only(top: Sizes.size20),
                    child: PostVideoButton(
                      isVideoButtonHovered: _isVideoButtonHovered,
                      onHover: _onHover,
                      inverted: _selectedIndex != 0,
                      onLongPressDown: _onLongPressDown,
                      onLongPressUp: _onLongPressUp,
                    ),
                  ),
                  destinations: [
                    for (var nav in navs2)
                      NavigationRailDestination(
                        icon: FaIcon(nav['icon']),
                        label: Text(nav['title']),
                      ),
                  ],
                ),
                VerticalDivider(
                  color: _selectedIndex == 0
                      ? Colors.grey.shade800
                      : Colors.grey.shade300,
                  thickness: 1,
                  width: 1,
                ),
                Expanded(
                  child: WebContainer(
                    maxWidth: 1400,
                    child: Stack(
                      children: [
                        for (var offStage in offStages2)
                          Offstage(
                            offstage:
                                _selectedIndex != offStages2.indexOf(offStage),
                            child: offStage,
                          )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                for (var offStage in offStages)
                  Offstage(
                    offstage: _selectedIndex != offStages.indexOf(offStage),
                    child: offStage,
                  )
              ],
            ),
      bottomNavigationBar: !isWebScreen(context)
          ? BottomAppBar(
              color: _selectedIndex == 0 ? Colors.black : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(Sizes.size12),
                child: CustomNavigation(
                  selectedIndex: _selectedIndex,
                  onTap: _onTap,
                  onHover: _onHover,
                  isVideoButtonHovered: _isVideoButtonHovered,
                  onLongPressUp: _onLongPressUp,
                  onLongPressDown: _onLongPressDown,
                ),
              ),
            )
          : null,
    );
  }
}
