import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/rawData/discover_taps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1, // 앱바와 바디 사이 구분선 효과
          title: const Text('Discover'),
          // PreferredSizeWidget bottom -> 자식의 크기를 제한하지 않는다. TabBar 가 대표적
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory, // 클릭 시 기본 번짐 효과 제거
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
            tabs: [
              for (var tab in tabs) Tab(text: tab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              itemCount: 20,
              padding: const EdgeInsets.all(Sizes.size6),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 16, // 그리드 비율
              ),
              itemBuilder: (context, index) => Container(
                color: Colors.teal,
                child: Center(
                  child: Text('$index'),
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
