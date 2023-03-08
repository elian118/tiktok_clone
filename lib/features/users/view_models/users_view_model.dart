import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/view_models/sign_up_view_model.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _usersRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);
    // 로그인 상태라면
    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersRepository.findProfile(
          _authenticationRepository.user!.uid); // 로그인한 사용자는 이미 uid 보유하고 있기 때문
      // 조회된 프로필 존재 시 로그인된 사용자 정보로 프로필 초기화 후 종료
      if (profile != null) return UserProfileModel.fromJson(profile);
    }

    return UserProfileModel.empty(); // 프로필 초기화(비움)
  }

  // 파이어스토어 -> 계정 생성 -> 회원 가입 시 연쇄 진행
  Future<void> createProfile(UserCredential userCredential) async {
    if (userCredential.user == null) throw Exception('Account not created');
    final form = ref.read(signUpForm); // 이름, 이메일, 비밀번호, 생일 정보 담긴 state
    state = const AsyncValue.loading();
    // 회원가입 성공 시 파이어오스로부터 반환된 userCredential 정보 일부를 state 에 주입
    final profile = UserProfileModel(
      hasAvatar: false,
      birthday: form['birthday'] ?? 'undefined',
      bio: 'undefined',
      link: 'undefined',
      email: userCredential.user!.email ?? 'anon@anon.com',
      uid: userCredential.user!.uid,
      name: form['username'] ?? userCredential.user!.displayName ?? 'Anon',
    );

    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile); // 사용자 정보 주입
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    // hasAvatar 값만 바꾼 기존 UserProfileModel 복사본 가져오기 -> 수정할 새로운 정보(hasAvatar: true) 추가
    //  -> state 주입 -> 화면에 변경사항 반영
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    // 프로필 수정
    await _usersRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }

  Future<void> updateUserBio(String bio) async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(bio: bio));
    // 프로필 수정
    await _usersRepository.updateUser(state.value!.uid, {"bio": bio});
  }

  Future<void> updateUserLink(String link) async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(link: link));
    // 프로필 수정
    await _usersRepository.updateUser(state.value!.uid, {"link": link});
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
    () => UsersViewModel());
