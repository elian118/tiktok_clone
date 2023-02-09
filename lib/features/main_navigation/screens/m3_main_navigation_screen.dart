import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/rawData/screens.dart';

// 매터리얼 디자인 3를 따르는 하단 NavigationBar 위젯 적용 예제
class M3MainNavigationScreen extends StatefulWidget {
  const M3MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<M3MainNavigationScreen> createState() => _M3MainNavigationScreenState();
}

class _M3MainNavigationScreenState extends State<M3MainNavigationScreen> {
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
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: Colors.amber,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.blue,
            ),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
