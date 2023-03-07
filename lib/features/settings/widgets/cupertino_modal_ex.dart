import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/screens/sign_up_screen.dart';
import 'package:tiktok_clone/utils/route_utils.dart';

class CupertinoModalEx extends ConsumerWidget {
  const CupertinoModalEx({
    super.key,
  });
  /*
  쿠퍼티노 모달 vs 쿠퍼티노 다이얼로그
   공통: 액션버튼 텍스트가 길어지면 좌우로 넓어짐
   차이
     1. 쿠퍼티노 모달은 다른 영역을 눌렀을 때 창이 알아서 닫힘
     2. 액션버튼 텍스트가 길어져 좌우로 꽉 찬 경우 -> 모달은 아래, 다이얼로그는 위로 배치됨
  */
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('Log out (iOS / Bottom)'),
      textColor: Colors.red,
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            title: const Text('Are you sure?'),
            message: const Text('Please dooooooon gooooo'),
            actions: [
              CupertinoActionSheetAction(
                isDefaultAction: true, // 기본 선택 효과 -> 폰트 굵게
                onPressed: () => navPop(context),
                child: const Text('Not log out'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  ref.read(authRepo).signOut();
                  // router.dart -> ref.watch(authState) 비활성화 시 아래 코드로 수동 리다이렉트
                  context.go(SignUpScreen.routeURL);
                },
                isDestructiveAction: true, // 폰트에 빨간색 입혀짐
                child: const Text('Yes, Please.'),
              ),
            ],
          ),
        );
      },
    );
  }
}
