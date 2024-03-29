import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/enums/breakpoints.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/rawData/video_data.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/view_models/video_post_view_model.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_bgm_info.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_intro_text2.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils/common_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final VideoModel videoData;
  final int index;

  const VideoPost({
    Key? key,
    required this.videoData,
    required this.onVideoFinished,
    required this.index,
  }) : super(key: key);

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;
  late final AnimationController _animationController;

  bool _isPause = false;
  bool _isMute = false;
  final List<String> _tags = tags;
  final String _bgmInfo = bgmInfo;
  final Duration _animationDuration = const Duration(milliseconds: 200);

  // 비디오플레이어 초기설정 - 컨트롤러 초기화 포함
  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.network(widget.videoData.fileUrl);
    await _videoPlayerController.initialize(); // Future<void> -> await
    // 반복 재생 설정 -> 영상 전환 없이 현재 영상에서 테스트할 게 있는 경우 활성화(영상 고정)
    // await _videoPlayerController.setLooping(true);

    // 웹 브라우저에서 애플리케이션이 실행된 경우
    if (kIsWeb) {
      // 음소거 부수 효과: 웹에서 영상 자동재생을 차단하려는 기본 설정으로 인해 발생하는 예외를 회피할 수 있다.
      // _toggleMute(true);
      if (!mounted) return;
      ref.read(playbackConfigProvider.notifier).setMuted(true);
      await _videoPlayerController.setVolume(0); // 음소거 처리
    }
    // 아래 코드들은 초기 설정에 불과하므로, 비디오 컨트롤러 초기화 여부와 무관하게 동기 처리 가능

    // 초기화(화면 띄움)과 동시에 동영상 자동 재생
    // _videoPlayerController.play();
    // -> 단, 이 방식은 다음 영상으로 완전히 화면이 넘어가기 전에 이미 다음 영상이 재생돼,
    //    스크롤 도중 이전 영상과 다음 영상이 동시 재생되는 현상 발생
    //    (시뮬레이터 드래그로 두 영상 위젯 모두 화면에 걸쳐보면 보임)
    // -> 화면이 완전히 넘어간 이후 재생하려면 VisibilityDetector() => onVisibilityChanged(info) {...}
    // 동영상 컨트롤러 상황을 주시하는 콜백 실행 설정
    _videoPlayerController.addListener(_onVideoChange);
    _onPlaybackConfigChanged();
    setState(() {}); // state 저장
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
    // State > mounted: 이(this) 스테이트가 현재 위젯 트리 안에 존재하는가?
    if (!mounted) return; // 없으면 실행 중단
    // VisibilityInfo.visibleFraction * 100 -> 위젯이 기기 화면에 얼마만큼 보이는 가를 백분율로 반환
    // print('Video: ${widget.index} is ${info.visibleFraction * 100}% visible.');

    // 조건식 -> 위젯이 기기 화면에 모두 보여야 재생 시작
    if (info.visibleFraction == 1 &&
        !_isPause &&
        !_videoPlayerController.value.isPlaying) {
      // 조건식 -> 자동재생 허용이면 재생 시작
      final autoplay = ref.read(playbackConfigProvider).autoplay;
      if (autoplay) _videoPlayerController.play();
      // final autoplay = context.read<PlaybackConfigViewModel>().autoplay;
      // if (autoplay) _videoPlayerController.play();
    }
    // 영상 재생 도중 다른 네비게이션 페이지로 이동한 경우(info.visibleFraction == 0) 일시 정지
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
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

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause(); // 코멘트 아이콘 탭 -> 영상 일시 정지
    }
    // 초간단 바닥모달시트 생성
    await showModalBottomSheet(
      constraints: const BoxConstraints(maxWidth: Breakpoint.sm),
      context: context,
      isScrollControlled: true, // 허용 시, 바닥모달시트 기본높이 한계치(50%)가 플림 -> 자식 높이에 좌우됨
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    );
    // 모달을 닫는 행위 => showModalBottomSheet() 종료
    _onTogglePause(); // 모달 닫기와 동시에 영상 재생
  }

  void _onPlaybackConfigChanged({bool toggle = false}) {
    // 지난 동영상의 addListener(_onPlaybackConfigChanged) 코드 실행 방지
    if (!mounted) return;
    _isMute = toggle ? !_isMute : ref.read(playbackConfigProvider).muted;
    _videoPlayerController.setVolume(_isMute ? 0 : 1);
    setState(() {});
  }

  void _onLikeTap() {
    ref
        .read(videoPostProvider(
                '${widget.videoData.id}000${ref.read(authRepo).user!.uid}')
            .notifier)
        .likeVideo();
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
  }

  // 모든 stateful widget 내 컨트롤러는 작업 후 반드시 위젯에서 제거 -> 누락 시, 시뮬레이터에서 에러 발생
  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ref
      .watch(videoPostProvider(
          '${widget.videoData.id}000${ref.read(authRepo).user!.uid}'))
      .when(
        data: (like) => VisibilityDetector(
          key: Key('${widget.index}'),
          onVisibilityChanged: _onVisibilityChanged,
          child: Stack(
            children: [
              Positioned.fill(
                child: _videoPlayerController.value.isInitialized
                    ? VideoPlayer(_videoPlayerController)
                    : Image.network(
                        widget.videoData.thumbnailUrl,
                        fit: BoxFit.cover,
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
              Positioned(
                bottom: 20,
                left: 10,
                child: SizedBox(
                  width: getWinWidth(context) - 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@${widget.videoData.creator}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v10,
                      VideoIntroText2(
                        descText: widget.videoData.description,
                        mainTextBold: FontWeight.normal,
                      ),
                      Gaps.v10,
                      VideoIntroText2(
                        descText: _tags.join(', '),
                        mainTextBold: FontWeight.w600,
                      ),
                      Gaps.v10,
                      VideoBgmInfo(bgmInfo: _bgmInfo),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  icon: FaIcon(
                    _isMute
                        ? FontAwesomeIcons.volumeXmark
                        : FontAwesomeIcons.volumeHigh,
                    color: Colors.white,
                  ),
                  onPressed: () => _onPlaybackConfigChanged(toggle: true),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Column(
                  children: [
                    Gaps.v24,
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      foregroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/tiktok-clone-elian.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media",
                      ),
                      child: Text(widget.videoData.creator),
                    ),
                    Gaps.v24,
                    GestureDetector(
                      onTap: _onLikeTap,
                      child: VideoButton(
                        color: like.isLikeVideo ? Colors.red : Colors.white,
                        icon: FontAwesomeIcons.solidHeart,
                        text: S.of(context).likeCount(like.likeCount),
                      ),
                    ),
                    Gaps.v24,
                    GestureDetector(
                      onTap: () => _onCommentsTap(context),
                      child: VideoButton(
                        icon: FontAwesomeIcons.solidComment,
                        text: S
                            .of(context)
                            .commentCount(widget.videoData.comments),
                      ),
                    ),
                    Gaps.v24,
                    const VideoButton(
                      icon: FontAwesomeIcons.share,
                      text: 'Share',
                    ),
                    Gaps.v38,
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      foregroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/73107356?v=4",
                      ),
                      child: Text('광회'),
                    ),
                  ],
                ),
              )
            ],
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
