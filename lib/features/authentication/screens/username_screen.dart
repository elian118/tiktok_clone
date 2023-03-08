import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/common/constants/enums/breakpoints.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/cst_text_field.dart';
import 'package:tiktok_clone/common/widgets/web_container.dart';
import 'package:tiktok_clone/features/authentication/screens/email_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/sign_up_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/utils/common_utils.dart';
import 'package:tiktok_clone/utils/route_utils.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  const UsernameScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = ''; // state 변수는 final 선언하지 않는다.

  void _onSubmit() {
    if (_username.isEmpty) return;
    ref.read(signUpForm.notifier).state = {"username": _username};
    navPush(context, EmailScreen(username: _username));
  }

  @override
  void initState() {
    super.initState(); // 첫 행이 아니어도 상관 없지만, 로직 파악 편의 상 메모리 정리 후 맨 윗행 위치 권장
    // 리빌드 때마다 리스너 실행 -> 추적하는 모든 TextField 정보(_usernameController)를 가져온다.
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text; // 그 중에서 입력된 텍스트만 가져와 대입
      });
    });
  }

  @override
  void dispose() {
    // 다른 인스턴스가 빌드될 때 _usernameController 제거(메모리 관리)
    _usernameController.dispose();
    super.dispose(); // 첫 행으로 가도 상관 없지만, 로직 파악 편의 상 메모리 정리 후 맨 아래 행 위치 권장
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusout(context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Sign up'),
        ),
        body: WebContainer(
          padding: const EdgeInsets.all(Sizes.size36),
          maxWidth: Breakpoint.sm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                'Create username',
                style: TextStyle(
                  fontSize: Sizes.size22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v8,
              const Text(
                'You can always change this later.',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black54,
                ),
              ),
              Gaps.v28,
              CstTextField(
                controller: _usernameController,
                hintText: 'Username',
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(disabled: _username.isEmpty),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
