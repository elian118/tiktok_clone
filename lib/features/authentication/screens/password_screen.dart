import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/enums/breakpoints.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/web_container.dart';
import 'package:tiktok_clone/features/authentication/screens/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/utils/utils.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = ''; // state 변수는 final 선언하지 않는다.
  bool _obscureText = true;

  @override
  void initState() {
    super.initState(); // 첫 행이 아니어도 상관 없지만, 로직 파악 편의 상 메모리 정리 후 맨 윗행 위치 권장
    // 리빌드 때마다 리스너 실행 -> 추적하는 모든 TextField 정보(_passwordController)를 가져온다.
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text; // 그 중에서 입력된 텍스트만 가져와 대입
      });
    });
  }

  @override
  void dispose() {
    // 다른 인스턴스가 빌드될 때 _passwordController 제거(메모리 관리)
    _passwordController.dispose();
    super.dispose(); // 첫 행으로 가도 상관 없지만, 로직 파악 편의 상 메모리 정리 후 맨 아래 행 위치 권장
  }

  // 비밀번호 유효성 검사
  bool _isTherePassword() {
    return _password.isNotEmpty &&
        _password.length >= 8 &&
        _password.length <= 20;
  }

  bool _isPasswordValid() {
    final regExp = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,20}$');
    return regExp.hasMatch(_password);
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  // 비밀번호 초기화
  void _onClearTap() {
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // PasswordScreen 전체를 GestureDetector 로 감싸 텍스트인풋 포커스 아웃 적용
    return GestureDetector(
      onTap: () => Utils.focusout(context),
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
                'Password?',
                style: TextStyle(
                  fontSize: Sizes.size22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v28,
              TextField(
                // 컨트롤러
                controller: _passwordController,
                // 시뮬레이터 메뉴 > I/O > Keyboard > Toggle Software Keyboard 선택해야 확인 가능
                keyboardType: TextInputType.emailAddress, // 이메일 형식 키보드 선택
                obscureText: _obscureText, // 입력 텍스트 감춤(비밀번호)
                autocorrect: false, // 키보드 상단 자동완성 기능 제거
                // 완료(done) 키 클릭 시, 실행할 콜백 설정
                onEditingComplete: () =>
                    Utils.navPush(context, const BirthdayScreen()),
                // 포커스 상태 밑줄 색상을 바꾸려면 enabledBorder, focusedBorder 두 속성을 모두 설정해야 한다.
                decoration: InputDecoration(
                  // suffixIcon => 플러터 기본 아이콘만 허용, 기본 스타일 이미 존재
                  // suffix => 위젯을 활용한 커스덤 용이
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min, // 자식들을 맨 뒤로 보내기 위한 최소값 설정
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  hintText: 'Make it strong!',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).disabledColor, // 활성 상태 밑줄 색상 지정
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context)
                          .focusColor, // 포커스 상태 => 활성 상태와 동일 색상 유지
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v10,
              const Text(
                'Your password must have:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: _isTherePassword()
                        ? Colors.green
                        : Theme.of(context).disabledColor,
                  ),
                  Gaps.h5,
                  const Text('8 to 20 characters'),
                ],
              ),
              Gaps.v5,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Theme.of(context).disabledColor,
                  ),
                  Gaps.h5,
                  const Text('Letters, numbers, and special characters'),
                ],
              ),
              Gaps.v28,
              // FormButton(password: _password) // 위젯 추출 v.1
              // 위젯 추출 v.2
              GestureDetector(
                onTap: () => Utils.navPush(context, const BirthdayScreen()),
                child: FormButton(disabled: !_isPasswordValid()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
