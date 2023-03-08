import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  FutureOr build() {
    _repository = ref.read(userRepo);
  }

  Future<void> uploadAvatar(
    // BuildContext context,
    // bool mounted,
    File file,
  ) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid; // 로그인된 현재 사용자 uid 를 파일명으로 지정

    state = await AsyncValue.guard(() async {
      await _repository.uploadAvatar(file, fileName);
      await ref.read(usersProvider.notifier).onAvatarUpload(); // 아바타 업로드 상태 변경
    });
    // if (!mounted) return;
    // if (state.hasError) showFirebaseErrorSnack(context, state.error);
  }
}

final avatarProvider =
    AsyncNotifierProvider<AvatarViewModel, void>(() => AvatarViewModel());
