import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/camera_control_buttons.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({Key? key}) : super(key: key);

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  bool _hasPermission = false;
  bool _deniedPermission = false;
  bool _isSelfieMode = false;
  // 전후면 카메라를 언제든 전환할 수 있으므로, 카메라 컨트롤러는 상수일 수 없다.
  late CameraController _cameraController;
  late FlashMode _flashMode;

  late final AnimationController _buttonAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200));

  late final AnimationController _progressAnimationController =
      AnimationController(
          vsync: this,
          duration: const Duration(seconds: 10),
          // 애니메이션 최소/최대값 지정
          lowerBound: 0.0,
          upperBound: 1.0);

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  Future<void> initCamera() async {
    // 앱이 설치된 기기에서 얼마나 많은 카메라를 제어할 수 있는지 확인
    final cameras = await availableCameras();
    // print(cameras);
    // I/flutter (  415): [CameraDescription(0, CameraLensDirection.back, 90), CameraDescription(1, CameraLensDirection.front, 270), CameraDescription(2, CameraLensDirection.back, 90)]
    if (cameras.isEmpty) return;
    try {
      // 후면 카메라 프리셋
      _cameraController = CameraController(
          cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.ultraHigh);
      await _cameraController.initialize(); // 후면 카메라 초기화
      // 카메라 플래시모드 상태 -> _flashMode state 연동
      _flashMode = _cameraController.value.flashMode;
    } catch (err) {
      if (err is CameraException) {
        switch (err.code) {
          case 'CameraAccessDenied':
            if (kDebugMode) print('User denied camera access.');
            break;
          default:
            if (kDebugMode) print('Handle other errors.');
            break;
        }
      }
    }
  }

  Future<void> initPermission() async {
    // 안드로이드와 iOS에서 사용자에게 접근 허용할 건지 묻는 팝업 등장
    final cameraPermission = await Permission.camera.request(); // 앱 사용중에만 허용 선택
    final micPermission =
        await Permission.microphone.request(); // 앱 사용중에만 허용 선택

    final isCameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final isMicDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    // 카메라, 마이크 접근 권한이 모두 확인되면 카메라 초기화
    if (!isCameraDenied && !isMicDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    } else {
      _deniedPermission = true;
      _cameraController.dispose();
      setState(() {});
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    // 전후면 카메라 전환 -> 카메라 컨트롤러 초기화 필요
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode); // 카메라 플레시모드 변경
    _flashMode = newFlashMode; // state 변경
    setState(() {});
  }

  void _startRecording(TapDownDetails details) {
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  void _stopRecording() {
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
  }

  @override
  void initState() {
    super.initState();
    initPermission();
    // _progressAnimationController.value 변화 추적
    _progressAnimationController.addListener(() {
      setState(() {}); // 변화가 감지되면 화면 갱신 -> 진행도 애니메이션 동작
    });
    // _progressAnimationController.status 변화 추적
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording(); // 변화가 감지되면 화면 갱신 -> 진행도 애니메이션 종료(리셋)
      }
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    !_deniedPermission
                        ? 'Initializing...'
                        : 'You do not have access to the camera.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v20,
                  !_deniedPermission
                      ? const CircularProgressIndicator.adaptive()
                      : const Text(
                          'Please reset the permission.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size20,
                          ),
                        ),
                ],
              )
            : SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CameraPreview(_cameraController),
                    Positioned(
                      top: Sizes.size10,
                      right: Sizes.size10,
                      child: CameraControlButtons(
                          controller: _cameraController,
                          flashMode: _flashMode,
                          setFlashMode: _setFlashMode,
                          toggleSelfieMode: _toggleSelfieMode),
                    ),
                    Positioned(
                      bottom: Sizes.size40,
                      child: GestureDetector(
                        onTapDown: _startRecording,
                        onTapUp: (detail) => _stopRecording,
                        child: ScaleTransition(
                          scale: _buttonAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: Sizes.size80,
                                height: Sizes.size80,
                                child: CircularProgressIndicator(
                                  color: Colors.amber.shade400,
                                  strokeWidth: Sizes.size6,
                                  value: _progressAnimationController
                                      .value, // 지정 시 로딩이 아닌, 진척도 표시로 전환됨다.
                                ),
                              ),
                              Container(
                                width: Sizes.size60,
                                height: Sizes.size60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.shade400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
