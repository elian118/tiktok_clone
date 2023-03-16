import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

// FamilyAsyncNotifier -> 빌드 시 매개변수를 받는 AsyncNotifier.
//  선언 시 제네럴에 매개변수 타입(Arg)을 두번째로 추가해야 한다.
class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _repository;
  late final String _videoId;

  @override
  FutureOr build(String videoId) {
    _videoId = videoId;
    _repository = ref.read(videosRepo);
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    await _repository.likeVideo(_videoId, user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
        () => VideoPostViewModel());
