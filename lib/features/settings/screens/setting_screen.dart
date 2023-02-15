import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Column(
          children: const [
            // CupertinoActivityIndicator(
            //   radius: 40,
            //   // animating: false,
            // ),
            // CircularProgressIndicator(),
            CircularProgressIndicator.adaptive(), // 간편 쿠퍼티노 스타일 매터리얼 인디케이터 적용
          ],
        )
        // body: const ListWheelScrollViewEx(),
        );
  }
}
