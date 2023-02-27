import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/web_container.dart';
import 'package:tiktok_clone/features/authentication/screens/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/utils/utils.dart';

import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        bool isLandscape = orientation == Orientation.landscape;
        // print(orientation);
        return Scaffold(
          body: SafeArea(
            child: WebContainer(
              padding: const EdgeInsets.all(Sizes.size36),
              maxWidth: 800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.v80,
                  Text(
                    'Sign up for TikTok',
                    style: Theme.of(context).textTheme.headlineSmall,
                    // headlineSmall 테마 스타일의 특정 속성만 변경해 사용하려면, copyWith 사용
                    // style: Theme.of(context)
                    //     .textTheme
                    //     .headlineSmall!
                    //     .copyWith(color: Colors.red),
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7, // 텍스트는 불투명도 설정이 테마별 색상을 직접 입력하는 방법보다 더 간편
                    child: Text(
                      'Create a profile, follow other accounts, make your own videos, and more.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  // 한 번에 여러 트리를 반환하는 경우, 배열화 후 전개연산자를 사용한다.
                  if (!isLandscape) ...[
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.user),
                      text: 'Use email & password',
                      onTapHandler: () =>
                          navPush(context, const UsernameScreen()),
                    ),
                    Gaps.v16,
                    const AuthButton(
                      icon: FaIcon(FontAwesomeIcons.facebook,
                          color: Colors.indigo),
                      text: 'Continue with Facebook',
                    ),
                    Gaps.v16,
                    const AuthButton(
                      icon: FaIcon(FontAwesomeIcons.apple),
                      text: 'Continue with Apple',
                    ),
                    Gaps.v16,
                    const AuthButton(
                      icon: FaIcon(FontAwesomeIcons.google),
                      text: 'Continue with Google',
                    ),
                  ],
                  if (isLandscape) ...[
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.user),
                            text: 'Use email & password',
                            onTapHandler: () =>
                                navPush(context, const UsernameScreen()),
                          ),
                        ),
                        Gaps.h16,
                        const Expanded(
                          child: AuthButton(
                            icon: FaIcon(FontAwesomeIcons.facebook,
                                color: Colors.indigo),
                            text: 'Continue with Facebook',
                          ),
                        ),
                      ],
                    ),
                    Gaps.v16,
                    Row(
                      children: const [
                        Expanded(
                          child: AuthButton(
                            icon: FaIcon(FontAwesomeIcons.apple),
                            text: 'Continue with Apple',
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            icon: FaIcon(FontAwesomeIcons.google),
                            text: 'Continue with Google',
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: isDarkMode(context)
                ? null // null -> 기본 다크테마 지정컬러 적용
                : Colors.grey.shade50,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => navPush(context, const LoginScreen()),
                    child: Text(
                      'Log in',
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
