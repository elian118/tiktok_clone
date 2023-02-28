import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/web_container.dart';
import 'package:tiktok_clone/features/authentication/screens/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils/utils.dart';

import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(Localizations.localeOf(context));
    }
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
                    // 'Sign up for TikTok',
                    // AppLocalizations.of(context)!.signUpTitle("TikTok"),
                    S.of(context).signUpTitle("TikTok"),
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
                      S.of(context).signUpSubtitle,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  // 한 번에 여러 트리를 반환하는 경우, 배열화 후 전개연산자를 사용한다.
                  if (!isLandscape) ...[
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.user),
                      text: S.of(context).emailPasswordButton,
                      onTapHandler: () =>
                          navPush(context, const UsernameScreen()),
                    ),
                    Gaps.v16,
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook,
                          color: Colors.indigo),
                      text: S.of(context).accountLoginButton(
                          isKorean(context) ? '페이스북' : 'Facebook'),
                    ),
                    Gaps.v16,
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.apple),
                      text: S.of(context).accountLoginButton(
                          isKorean(context) ? '애플' : 'Apple'),
                    ),
                    Gaps.v16,
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.google),
                      text: S.of(context).accountLoginButton(
                          isKorean(context) ? '구글' : 'Google'),
                    ),
                  ],
                  if (isLandscape) ...[
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.user),
                            text: S.of(context).emailPasswordButton,
                            onTapHandler: () =>
                                navPush(context, const UsernameScreen()),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.facebook,
                                color: Colors.indigo),
                            text: S.of(context).accountLoginButton(
                                isKorean(context) ? '페이스북' : 'facebook'),
                          ),
                        ),
                      ],
                    ),
                    Gaps.v16,
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.apple),
                            text: S.of(context).accountLoginButton(
                                isKorean(context) ? '애플' : 'Apple'),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.google),
                            text: S.of(context).accountLoginButton(
                                isKorean(context) ? '구글' : 'Google'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          // 매터리얼3 디자인은 BottomNavigationBar 를 사용하지 않으므로, Container 를 대신 사용한다.
          bottomNavigationBar: Container(
            color: isDarkMode(context)
                ? null // null -> 기본 다크테마 지정컬러 적용
                : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).alreadyHaveAnAccount),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => navPush(context, const LoginScreen()),
                    child: Text(
                      S.of(context).logIn,
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
