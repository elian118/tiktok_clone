import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: const [
          // ListTile(
          //   onTap: () => showAboutDialog(
          //     context: context,
          //     applicationVersion: "v 1.0",
          //     applicationLegalese:
          //         "Copyright(c) All rights reserved. Please don't copy me.",
          //   ),
          //   title: const Text(
          //     'About',
          //     style: TextStyle(
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          //   subtitle: const Text("About this app.."),
          // ),
          // 위 코드를 간소화한 위젯
          AboutListTile(
            applicationVersion: "v 1.0",
            applicationLegalese:
                "Copyright(c) All rights reserved. Please don't copy me.",
          ),
        ],
      ),
      // 이하, ListWheelScrollViewEx, CupertinoActivityIndicator, CircularProgressIndicator 샘플
      // body: Column(
      //   children: const [
      //     // CupertinoActivityIndicator(
      //     //   radius: 40,
      //     //   // animating: false,
      //     // ),
      //     // CircularProgressIndicator(),
      //     CircularProgressIndicator.adaptive(), // 간편 쿠퍼티노 스타일 매터리얼 인디케이터 적용
      //   ],
      // ),
      // body: const ListWheelScrollViewEx(),
    );
  }
}
