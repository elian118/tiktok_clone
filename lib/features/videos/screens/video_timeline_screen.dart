import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({Key? key}) : super(key: key);

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final PageController _pageController = PageController();

  final _scrollDuration = const Duration(milliseconds: 250);
  final _scrollCurve = Curves.linear;
  int _itemCount = 4;

  void _onPageChange(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      setState(() {});
    }
  }

  void _onVideoFinished() {
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  // 모든 stateful widget 내 컨트롤러는 작업 후 반드시 위젯에서 제거 -> 누락 시, 시뮬레이터에서 에러 발생
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
      itemCount: _itemCount,
      // pageSnapping: false, // 페이지 자동 끌어당김 효과 해제
      itemBuilder: (context, index) => VideoPost(
        onVideoFinished: _onVideoFinished,
      ),
    );
  }
}
