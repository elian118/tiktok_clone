import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void callDialog(
  BuildContext context, {
  double? width,
  double? height,
  required Widget child,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        clipBehavior: Clip.hardEdge,
        content: Builder(
          builder: (context) => SizedBox(
            height: height,
            width: width,
            child: child,
          ),
        ),
      ),
    );

void showFirebaseErrorSnack(BuildContext context, Object? error) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    // showCloseIcon: true, // 닫기 아이콘 버튼 활성화
    action: SnackBarAction(
      onPressed: () {}, // 닫기와 같은 결과
      label: 'OK',
    ),
    // state.error.toString() => [firebase_auth/invalid-email] The email address is badly formatted.
    // (state.error as FirebaseException).message => The email address is badly formatted.
    content:
        Text((error as FirebaseException).message ?? "Something wen't wrong"),
  ));
}
