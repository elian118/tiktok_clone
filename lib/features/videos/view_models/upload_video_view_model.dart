import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr build() {
    _repository = ref.read(videosRepo);
  }

  Future<void> uploadVideo(
    File video,
    String title,
    String description,
    BuildContext context,
    bool mounted,
  ) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;

    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final task = await _repository.uploadVideoFile(video, user!.uid);
        // 파일 업로드에 성공한 경우
        if (task.metadata != null) {
          await _repository.saveVideo(
            VideoModel(
              id: '',
              title: title,
              description: description,
              fileUrl: await task.ref.getDownloadURL(),
              thumbnailUrl: '', // 파이어베이스 펑션에서 리턴할 예정이므로 초기값 비움
              creatorUid: user.uid,
              likes: 0,
              comments: 0,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              creator: userProfile.name,
            ),
          );
          if (!mounted) return;
          // 성공하면 뒤로가기 두 번
          context.pop();
          context.pop();
        }
      });
    }
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
    () => UploadVideoViewModel());
