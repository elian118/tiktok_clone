import 'package:flutter/material.dart';

class CstTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? hintText;
  final bool? autocorrect;
  final Widget? suffix;
  final void Function()? onEditingComplete;

  const CstTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText,
    this.autocorrect,
    this.suffix,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      // 컨트롤러
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false, // 입력 텍스트 감춤(비밀번호)
      autocorrect: autocorrect ?? true, // 키보드 상단 자동완성 기능 제거
      // 포커스 상태 밑줄 색상을 바꾸려면 enabledBorder, focusedBorder 두 속성을 모두 설정해야 한다.
      decoration: InputDecoration(
        hintText: hintText,
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
        suffix: suffix,
      ),
      cursorColor: Theme.of(context).primaryColor,
      onEditingComplete: onEditingComplete,
    );
  }
}
