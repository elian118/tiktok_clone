import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/common/constants/enums/breakpoints.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/web_container.dart';
import 'package:tiktok_clone/features/authentication/screens/password_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/sign_up_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/utils/common_utils.dart';
import 'package:tiktok_clone/utils/route_utils.dart';

class EmailScreenArgs {
  final String username;

  EmailScreenArgs({required this.username});
}

class EmailScreen extends ConsumerStatefulWidget {
  final String username;

  const EmailScreen({Key? key, required this.username}) : super(key: key);

  @override
  ConsumerState<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  String _email = ''; // state 변수는 final 선언하지 않는다.

  @override
  void initState() {
    super.initState(); // 첫 행이 아니어도 상관 없지만, 로직 파악 편의 상 메모리 정리 후 맨 윗행 위치 권장
    // 리빌드 때마다 리스너 실행 -> 추적하는 모든 TextField 정보(_emailController)를 가져온다.
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text; // 그 중에서 입력된 텍스트만 가져와 대입
      });
    });
  }

  @override
  void dispose() {
    // 다른 인스턴스가 빌드될 때 _emailController 제거(메모리 관리)
    _emailController.dispose();
    super.dispose(); // 첫 행으로 가도 상관 없지만, 로직 파악 편의 상 메모리 정리 후 맨 아래 행 위치 권장
  }

  // 이메일 유효성 검사
  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    // 정규식 파라미터 앞에 r을 입력 -> 다트 코드 포매팅 자동 문자열 변환 현상 방지
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) return 'Email is Not valid';
    return null;
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    ref.read(signUpForm.notifier).state = {"email": _email};
    navPush(context, const PasswordScreen());
  }

  @override
  Widget build(BuildContext context) {
    // EmailScreen 전체를 GestureDetector 로 감싸 텍스트인풋 포커스 아웃 적용
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
              Text(
                'What is your email, ${widget.username}?',
                style: const TextStyle(
                  fontSize: Sizes.size22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v28,
              TextField(
                // 컨트롤러
                controller: _emailController,
                // 시뮬레이터 메뉴 > I/O > Keyboard > Toggle Software Keyboard 선택해야 확인 가능
                keyboardType: TextInputType.emailAddress, // 이메일 형식 키보드 선택
                autocorrect: false, // 키보드 상단 자동완성 기능 제거
                // 완료(done) 키 클릭 시, 실행할 콜백 설정
                onEditingComplete: () =>
                    navPush(context, const PasswordScreen()),
                // 포커스 상태 밑줄 색상을 바꾸려면 enabledBorder, focusedBorder 두 속성을 모두 설정해야 한다.
                decoration: InputDecoration(
                  hintText: 'Email',
                  errorText: _isEmailValid(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).disabledColor, // 활성 상태 밑줄 색상 지정
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).focusColor, // 포커스 상태
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v28,
              // FormButton(email: _email) // 위젯 추출 v.1
              // 위젯 추출 v.2
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                    disabled: _email.isEmpty || _isEmailValid() != null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
