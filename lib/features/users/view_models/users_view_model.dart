import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;

  @override
  FutureOr<UserProfileModel> build() async {
    _repository = ref.read(userRepo);
    return UserProfileModel.empty(); // 기본 비움
  }

  // 파이어스토어 -> 계정 생성 -> 회원 가입 시 연쇄 진행
  Future<void> createProfile(UserCredential userCredential) async {
    if (userCredential.user == null) throw Exception('Account not created');
    state = const AsyncValue.loading();
    // 회원가입 성공 시 파이어오스로부터 반환된 userCredential 정보 일부를 state 에 주입
    final profile = UserProfileModel(
      bio: 'undefined',
      link: 'undefined',
      email: userCredential.user!.email ?? 'anon@anon.com',
      uid: userCredential.user!.uid,
      name: userCredential.user!.displayName ?? 'Anon',
    );
    await _repository.createProfile(profile);
    state = AsyncValue.data(profile); // 사용자 정보 주입
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
    () => UsersViewModel());
