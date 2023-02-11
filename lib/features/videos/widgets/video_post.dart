import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final int index;
  final VoidCallback onVideoFinished;

  const VideoPost(
      {Key? key, required this.onVideoFinished, required this.index})
      : super(key: key);

  @override
  State<VideoPost> createState() => _VideoPostState();
}

// 애니메이션 컨트롤러 적용 시 SingleTickerProviderStateMixin 믹싱
class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/videos/flowers_149958.mp4');

  bool _isPause = false;

  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  // 비디오플레이어 초기설정 - 컨트롤러 초기화 포함
  void _initVideoPlayer() async {
    // 비디오 컨트롤러는 기기 성능에 따라, 준비시간소요 편차 존재 -> 비동기로 초기화
    await _videoPlayerController.initialize();

    // 아래 코드들은 초기 설정에 불과하므로, 비디오 컨트롤러 초기화 여부와 무관하게 동기 처리 가능

    // 초기화(화면 띄움)과 동시에 동영상 자동 재생
    // _videoPlayerController.play();
    // -> 단, 이 방식은 다음 영상으로 완전히 화면이 넘어가기 전에 이미 다음 영상이 재생돼,
    //    스크롤 도중 이전 영상과 다음 영상이 동시 재생되는 현상 발생
    //    (시뮬레이터 드래그로 두 영상 위젯 모두 화면에 걸쳐보면 보임)
    // -> 화면이 완전히 넘어간 이후 재생하려면 VisibilityDetector() => onVisibilityChanged(info) {...}

    setState(() {}); // state 저장
    // 동영상 컨트롤러 상황을 주시하는 콜백 실행 설정
    _videoPlayerController.addListener(_onVideoChange);
  }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      // 영상 전체 길이 == 영상 현재 위치 => 영상 다 본 상태
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    // VisibilityInfo.visibleFraction * 100 -> 위젯이 기기 화면에 얼마만큼 보이는 가를 백분율로 반환
    // print('Video: ${widget.index} is ${info.visibleFraction * 100}% visible.');
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play(); // 조건식 -> 위젯이 기기 화면에 모두 보여야 재생 시작
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      // 애니메이션 반대로 돌림
      _animationController.reverse(); // _animationController.value: 1.5 -> 1.0
    } else {
      _videoPlayerController.play();
      // 애니메이션 앞으로 돌림
      _animationController.forward(); // _animationController.value: 1.0 -> 1.5
    }
    setState(() {
      _isPause = !_isPause;
    });
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this, // this: SingleTickerProviderStateMixin 스테이트 인스턴스
      lowerBound: 1.0, // 최소값
      upperBound: 1.5, // 최대값
      value: 1.5, // 기본값(초기값)
      duration: _animationDuration,
    );
    /*
    아래 코드는 AnimatedBuilder 위젯으로 대체할 수 있다.

    _animationController.addListener(() {
      print(_animationController.value); // 값 변경 확인
      //_animationController.value 변경될 때마다 state 변경 -> 강제 리빌드 유도 -> 애니메이션 연출
      setState(() {});
    });

    효과: AnimatedBuilder 에 animation 컨트롤러만 지정하면
      래핑된 부분만 연속 리빌드를 유발해 애니메이션 효과 간편 적용 가능

      AnimatedBuilder(
        animation: _animationController, // .addListener(() {...})를 적용할 애니메이션 컨트롤러 주입
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: _animationController.value,
            child: child, // AnimatedOpacity(...)
          );
        },
      )

    참고: 접미사 Builder 붙는 모든 빌더 위젯은 대부분
      리빌드(리랜더링)를 유도하는 initState(), dispose()가 기본로직이 설정된 스테이트풀 위젯이다.
      빌더 위젯들은 일반적으로 builder 속성에 각 위젯 목적에 맞는 리빌드 콜백을 지정하도록 돼 있다.
    */
  }

  // 모든 stateful widget 내 컨트롤러는 작업 후 반드시 위젯에서 제거 -> 누락 시, 시뮬레이터에서 에러 발생
  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // build 메서드는 state 변경(setState(() {})마다 재실행되며 화면을 다시 그린다.
  // 즉, setState(() {})가 부드럽게 변화하는 값을 반영해 연속 실행될 경우, 애니메이션 효과 발생
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${widget.index}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.teal,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            // 아이콘이 자체 내장한 클릭 이벤트 무시 -> 형제 위젯의 GestureDetector 만 인식
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child, // AnimatedOpacity(...)
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPause ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
