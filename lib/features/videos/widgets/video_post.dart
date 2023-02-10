import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  final VoidCallback onVideoFinished;

  const VideoPost({Key? key, required this.onVideoFinished}) : super(key: key);

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/videos/flowers_149958.mp4');

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      // 영상 전체 길이 == 영상 현재 위치 => 영상 다 본 상태
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  // 비디오플레이어 초기설정 - 컨트롤러 초기화 포함
  void _initVideoPlayer() async {
    // 비디오 컨트롤러는 기기 성능에 따라, 준비시간소요 편차 존재 -> 비동기로 초기화
    await _videoPlayerController.initialize();
    // 아래 코드들은 초기 설정에 불과하므로, 비디오 컨트롤러 초기화 여부와 무관하게 동기 처리 가능
    _videoPlayerController.play(); // 화면 띄움과 동시에 동영상 자동 재생 설정
    setState(() {}); // state 저장
    // 동영상 컨트롤러 상황을 주시하는 콜백 실행 설정
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  // 모든 stateful widget 내 컨트롤러는 작업 후 반드시 위젯에서 제거 -> 누락 시, 시뮬레이터에서 에러 발생
  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Container(
                  color: Colors.teal,
                ),
        ),
      ],
    );
  }
}
