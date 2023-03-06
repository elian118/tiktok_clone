import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/common/constants/rawData/video_data.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({Key? key}) : super(key: key);

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  final PageController _pageController = PageController();

  final _scrollDuration = const Duration(milliseconds: 250);
  final _scrollCurve = Curves.linear;
  List<String> _rawVideos = [...rawVideos];

  void _onPageChange(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _rawVideos.length - 1) {
      _rawVideos = [..._rawVideos, ...rawVideos];
      setState(() {});
    }
  }

  void _onVideoFinished() {
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  Future<void> _onRefresh() {
    return Future.delayed(
      const Duration(seconds: 5),
    );
  }

  // 모든 stateful widget 내 컨트롤러는 작업 후 반드시 위젯에서 제거 -> 누락 시, 시뮬레이터에서 에러 발생
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      // when() -> AsyncNotifier 를 상속받은 비동기 뷰 모델을 가져다 쓸 때 사용 -> data, error, child 속성 보유
      ref.watch(timelineProvider).when(
            data: (videos) => RefreshIndicator(
              edgeOffset: 20, // 최초 등장 위치(0: 맨 위)
              // 최초 등장 위치로부터 거리 -> 드래그로 넓힌 거리가 상하 50 이상이면 흰 바탕 없어짐
              displacement: 50,
              color: Theme.of(context).primaryColor,
              // strokeWidth: 5, // 인디케이터 두께
              onRefresh: _onRefresh,
              /* PageView, ListView, ListTile, ... 등은 주로 builder 정적 메서드 활용
             1) PageView() -> 모든 'children: [...요소]'를 한 번에 빌드 -> 시스템 부담 큼
             2) PageView.builder() -> 화면에 보여질 일부 'itemBuilder: (context, index) => 요소'만 실시간 빌드
              -> 성능 최적화 */
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: _onPageChange,
                itemCount: videos.length,
                // pageSnapping: false, // 페이지 자동 끌어당김 효과 해제
                itemBuilder: (context, index) => VideoPost(
                  onVideoFinished: _onVideoFinished,
                  video: videos[index].title,
                  index: index,
                ),
              ),
            ),
            error: (error, stackTrace) => Center(
              child: Text(
                'Could not load videos. $error',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
}
