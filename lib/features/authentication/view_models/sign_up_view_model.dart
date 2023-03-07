import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp() async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm); // 이메일, 비밀번호 정보 담긴 state

    // AsyncValue.guard -> try-catch ->
    //  성공하면 AsyncValue.data(await future())
    //  실패하면 AsyncValue.error(err, stack) 반환
    state = await AsyncValue.guard(() async =>
        await _authRepo.emailSignUp(form['email'], form['password']));
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
