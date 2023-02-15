import 'package:flutter/material.dart';

// CupertinoActivityIndicator, CircularProgressIndicator 샘플
class IndicatorEx extends StatelessWidget {
  const IndicatorEx({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // CupertinoActivityIndicator(
        //   radius: 40,
        //   // animating: false,
        // ),
        // CircularProgressIndicator(),
        CircularProgressIndicator.adaptive(), // 간편 쿠퍼티노 스타일 매터리얼 인디케이터
      ],
    );
  }
}
