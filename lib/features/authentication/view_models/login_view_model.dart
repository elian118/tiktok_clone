import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/utils/dialog_utils.dart';

class LoginViewModel extends AsyncNotifier {
  late AuthenticationRepository _repository;

  @override
  FutureOr build() {
    _repository = ref.read(authRepo);
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
    bool mounted,
  ) async {
    state = const AsyncValue.loading();
    // try-catch
    state = await AsyncValue.guard(
        () async => await _repository.signIn(email, password));
    if (!mounted) return;
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go('/home');
    }
  }
}

final loginProvider =
    AsyncNotifierProvider<LoginViewModel, void>(() => LoginViewModel());
