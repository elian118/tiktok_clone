import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/screens/sign_up_screen.dart';
import 'package:tiktok_clone/utils/route_utils.dart';

class AndroidDialogEx extends ConsumerWidget {
  const AndroidDialogEx({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('Log out (Android)'),
      textColor: Colors.red,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            // icon: const FaIcon(FontAwesomeIcons.skull),
            title: const Text('Are you sure?'),
            content: const Text("Please don't go"),
            actions: [
              IconButton(
                onPressed: () => navPop(context),
                icon: const FaIcon(FontAwesomeIcons.car),
              ),
              TextButton(
                onPressed: () {
                  ref.read(authRepo).signOut();
                  // router.dart -> ref.watch(authState) 비활성화 시 아래 코드로 수동 리다이렉트
                  context.go(SignUpScreen.routeURL);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
    );
  }
}
