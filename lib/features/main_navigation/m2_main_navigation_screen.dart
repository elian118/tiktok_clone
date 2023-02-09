import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/rawData/screens.dart';

// 매터리얼 디자인 2를 따르는 하단 BottomNavigationBar 위젯 적용 예제
class M2MainNavigationScreen extends StatefulWidget {
  const M2MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<M2MainNavigationScreen> createState() => _M2MainNavigationScreenState();
}

class _M2MainNavigationScreenState extends State<M2MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // BottomNavigationBarType.fixed -> 아이템 갯수와 screens 수가 일치해야 일부 속성 작동. ex. backgroundColor
        // BottomNavigationBarType.shifting, -> 아이템 갯수와 screens 수 불일치 무관하게 모든 속성 작동
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        // selectedItemColor: Theme.of(context).primaryColor,
        // 둘 이상의 아이템이 있어야 에러가 사라진다.
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Home',
            tooltip: 'go home',
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: 'Search',
            tooltip: 'searching for something',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Item1',
            tooltip: 'what is it?',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: 'Item2',
            tooltip: 'what is it?',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: 'Item3',
            tooltip: 'what is it?',
            backgroundColor: Colors.cyan,
          ),
        ],
      ),
    );
  }
}
