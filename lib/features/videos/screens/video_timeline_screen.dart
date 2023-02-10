import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({Key? key}) : super(key: key);

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final PageController _pageController = PageController();

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.teal,
  ];

  void _onPageChange(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
    if (page == colors.length - 1) {
      colors.addAll([...colors]);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // PageView, ListView, ListTile, ... 등은 주로 builder 정적 메서드 활용
    // 1) PageView() -> 모든 'children: [...요소]'를 한 번에 빌드 -> 시스템 부담 큼
    // 2) PageView.builder() -> 화면에 보여질 일부 'itemBuilder: (context, index) => 요소'만 실시간 빌드
    // -> 성능 최적화
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChange,
      itemCount: colors.length,
      // pageSnapping: false, // 페이지 자동 끌어당김 효과 해제
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            'Screen $index',
            style: const TextStyle(fontSize: 68),
          ),
        ),
      ),
    );
  }
}
