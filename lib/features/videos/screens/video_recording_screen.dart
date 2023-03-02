import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({Key? key}) : super(key: key);

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;
  bool _deniedPermission = false;
  late final CameraController _cameraController;

  Future<void> initCamera() async {
    // 앱이 설치된 기기에서 얼마나 많은 카메라를 제어할 수 있는지 확인
    final cameras = await availableCameras();
    // print(cameras);
    // I/flutter (  415): [CameraDescription(0, CameraLensDirection.back, 90), CameraDescription(1, CameraLensDirection.front, 270), CameraDescription(2, CameraLensDirection.back, 90)]
    if (cameras.isEmpty) return;
    try {
      // 후면 카메라 프리셋
      _cameraController =
          CameraController(cameras[0], ResolutionPreset.ultraHigh);
      await _cameraController.initialize(); // 후면 카메라 초기화
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

  @override
  void initState() {
    super.initState();
    initPermission();
  }

  @override
  void dispose() {
    _cameraController.dispose();
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
            : Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController),
                ],
              ),
      ),
    );
  }
}
