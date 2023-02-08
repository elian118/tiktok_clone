import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/screens/interests_screen.dart';
import 'package:tiktok_clone/utils/utils.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({Key? key}) : super(key: key);

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

// 다수의 입력 필드들을 하나의 폼에서 제어하려면, 폼 접근자를 활용해야 효율적이다.
class _LoginFormScreenState extends State<LoginFormScreen> {
  // 폼 접근자 선언 -> 리액트 useRef 접근자 역할 동일
  // stateful widget instance
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {}; // 서버로 전송할 폼 데이터

  // 실행 시점의 Form stateful 위젯 인스턴스 내 모든 TextFormField -> validator 콜백 실행
  // validator 중 하나라도 반환 문자열이 있으면, validate() => false -> 유효성 위반 처리
  void _onSubmitTap() {
    // nullable currentState 사용 방식도 useRef 와 동일
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        // 입력값 모두 유효하면, 폼 안에 위치한 모든 TextFormField -> onSaved 실행
        _formKey.currentState?.save();
        // 폼 데이터 확인
        print(formData);
        // print(formData.keys);
        // print(formData.values);
        Utils.scrMoveTo(context, const InterestsScreen());
      }
    }
  }

  void _onSavedFn(String field, String? newValue) {
    if (newValue != null) formData[field] = newValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.focusout(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please write your email";
                    }
                    return null;
                  },
                  onSaved: (newValue) => _onSavedFn('email', newValue),
                ),
                Gaps.v16,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please write password';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _onSavedFn('password', newValue),
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(
                    disabled: false,
                    text: 'Log in',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
