import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({Key? key}) : super(key: key);

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

// 다수의 입력 폼들을 하나의 화면에서 제어할 경우, 접근자를 활용해야 효율적이다.
class _LoginFormScreenState extends State<LoginFormScreen> {
  // 접근자 선언 -> 리액트 useRef 접근자 역할 동일
  // stateful widget instance
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  // 콜백 실행 시점의 Form stateful 위젯 인스턴스 validate() 메서드 실행
  void _onSubmitTap() {
    // nullable currentState 사용 방식도 useRef 와 동일
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save(); // onSaved 콜백 실행
        // test
        // print(formData);
        // print(formData.keys);
        // print(formData.values);
      }
    }
    ;
  }

  void _onSavedFn(String field, String? newValue) {
    if (newValue != null) formData[field] = newValue;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
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
                  decoration: const InputDecoration(hintText: 'Email'),
                  // validator: (value) => "i don't like your email",
                  onSaved: (newValue) => _onSavedFn('email', newValue),
                ),
                Gaps.v16,
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Password'),
                  // validator: (value) => "wrong password",
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
