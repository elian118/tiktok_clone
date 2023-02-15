import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/rawData/discovers.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/utils/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 1;
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
      body: Stack(
        children: [
          for (var offStage in offStages)
            Offstage(
              offstage: _selectedIndex != offStages.indexOf(offStage),
              child: offStage,
            )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: 'Home',
                icon: FontAwesomeIcons.house,
                isSelected: _selectedIndex == 0,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: 'Discover',
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                isSelected: _selectedIndex == 1,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              Gaps.h24,
              GestureDetector(
                // onPanUpdate: _onPanUpdate,
                onLongPressUp: _onLongPressUp,
                onLongPressDown: _onLongPressDown,
                onTap: () => Utils.navPush(
                  context,
                  Scaffold(
                    appBar: AppBar(
                      title: const Text('Record video'),
                    ),
                  ),
                  true,
                ),
                child: PostVideoButton(
                  isVideoButtonHovered: _isVideoButtonHovered,
                  onHover: _onHover,
                  inverted: _selectedIndex != 0,
                ),
              ),
              Gaps.h24,
              NavTab(
                text: 'Inbox',
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                isSelected: _selectedIndex == 3,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: 'Profile',
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                isSelected: _selectedIndex == 4,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
