import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/screens/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        bool isLandscape = orientation == Orientation.landscape;
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isLandscape ? 560 : Sizes.size36,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  const Text(
                    'Log in to TikTok',
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  const Text(
                    'Manage your account, check notifications, comment on videos, and more.',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  GestureDetector(
                    onTap: () =>
                        Utils.navPush(context, const LoginFormScreen()),
                    child: const AuthButton(
                      // font_awesome_flutter 패키지 설치 이후 사용 가능
                      icon: FaIcon(FontAwesomeIcons.user),
                      text: 'Use email & password',
                    ),
                  ),
                  Gaps.v16,
                  const AuthButton(
                    icon:
                        FaIcon(FontAwesomeIcons.facebook, color: Colors.indigo),
                    text: 'Continue with Facebook',
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
          bottomNavigationBar: BottomAppBar(
            color: Colors.grey.shade50,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => Utils.navPop(context),
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
