import 'package:flutter/material.dart';

class Utils {
  // 스크린 이동
  static void scrMoveTo(BuildContext context, Widget widget) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  // 포커스 아웃 -> 자식 위젯의 GestureDetector 영역(여기서는 TextField)을 제외한 부모 위젯에서만 발동
  static void focusout(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
