import 'package:flutter/cupertino.dart';
import 'package:tiktok_clone/common/constants/rawData/screens.dart';

// 쿠퍼티노 디자인을 따르는 하단 CupertinoTabBar 위젯 적용 예제 -> main.dart -> CupertinoApp 적용해야 잘 나옴
class CupertinoMainNavigationScreen extends StatefulWidget {
  const CupertinoMainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<CupertinoMainNavigationScreen> createState() =>
      _CupertinoMainNavigationScreenState();
}

class _CupertinoMainNavigationScreenState
    extends State<CupertinoMainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
        ],
      ),
      tabBuilder: (context, index) => screens[index],
    );
  }
}
