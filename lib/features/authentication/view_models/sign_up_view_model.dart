import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/onboarding/screens/interests_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/utils/dialog_utils.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context, bool mounted) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm); // 이메일, 비밀번호 정보 담긴 state
    final users = ref.read(usersProvider.notifier);

    // AsyncValue.guard -> try-catch ->
    //  성공하면 AsyncValue.data(await future())
    //  실패하면 AsyncValue.error(err, stack) 반환
    state = await AsyncValue.guard(() async {
      final userCredential =
          await _authRepo.emailSignUp(form['email'], form['password']);
      // 파이어스토어에 프로필 저장 -> 에러가 있다면 뷰 모델에 에러 전달해 예외 처리
      await users.createProfile(userCredential);
      // print(userCredential.user); // 크레덴셜 정보 확인
    });
    if (!mounted) return;
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(InterestsScreen.routeName);
    }
  }
}

// StateProvider: 외부에서 변경 가능한 전역 state 제공
final signUpForm = StateProvider((ref) => {});
/*
  ref.read(signUpForm.notifier).state 로 접근해 수정 가능
  이메일 추가: ref.read(signUpForm.notifier).state = {"email": _email};
  비밀번호 추가: ref.read(signUpForm.notifier).state = {...state, 'password': _password};
*/

final signUpProvider =
    AsyncNotifierProvider<SignUpViewModel, void>(() => SignUpViewModel());
