import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  @override
  FutureOr<UserProfileModel> build() async {
    // 로그인한 상태라면 로그인 유저 정보 채움
    return UserProfileModel.empty(); // 기본 비움
  }

  // 파이어스토어 -> 계정 생성 -> 회원 가입 시 연쇄 진행
  Future<void> createAccount(UserCredential userCredential) async {
    if (userCredential.user == null) throw Exception('Account not created');
    state = AsyncValue.data(
      UserProfileModel(
        bio: 'undefined',
        link: 'undefined',
        email: userCredential.user!.email ?? 'anon@anon.com',
        uid: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? 'Anon',
      ),
    );
  }
}

final usersProvider = AsyncNotifierProvider(() => UsersViewModel());
