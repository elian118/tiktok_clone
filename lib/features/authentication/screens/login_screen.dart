import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/enums/breakpoints.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/web_container.dart';
import 'package:tiktok_clone/features/authentication/screens/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils/common_utils.dart';
import 'package:tiktok_clone/utils/route_utils.dart';

class LoginScreen extends ConsumerWidget {
  static const String routeName = "login";
  static const String routeURL = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          body: SafeArea(
            child: WebContainer(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(Sizes.size36),
              maxWidth: Breakpoint.sm,
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    // 'Log in to TikTok',
                    S.of(context).loginTitle('TikTok'),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      'Manage your account, check notifications, comment on videos, and more.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  GestureDetector(
                    // onTap: () => navPush(context, const UsernameScreen()),
                    onTap: () => navPush(context, const LoginFormScreen()),
                    child: const AuthButton(
                      // font_awesome_flutter 패키지 설치 이후 사용 가능
                      icon: FaIcon(FontAwesomeIcons.user),
                      text: 'Use email & password',
                    ),
                  ),
                  Gaps.v16,
                  GestureDetector(
                    onTap: () => ref
                        .read(socialAuthProvider.notifier)
                        .githubSignIn(context, true),
                    child: const AuthButton(
                      icon: FaIcon(FontAwesomeIcons.github),
                      text: 'Continue with Github',
                    ),
                  ),
                  Gaps.v16,
                  const AuthButton(
                    icon: FaIcon(FontAwesomeIcons.apple),
                    text: 'Continue with Google',
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: isDarkMode(context) ? null : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => goRoutePop(context),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
