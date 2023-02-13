import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/screens/main_navigation_screen.dart';

void main() {
  runApp(const TickTokApp());
}

class TickTokApp extends StatelessWidget {
  const TickTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Clone',
      // 전역 테마 설정
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // 스카폴드 배경
        primaryColor: const Color(0xFFE9435A), // 주 컬러
        focusColor: Colors.pink, // 포커스 컬러
        disabledColor: Colors.grey.shade200, // 비활성 컬러
        // splashColor: Colors.transparent, // 탭할 때 번짐 컬러 제거 -> 현재 버전에선 차이 없음
        // highlightColor: Colors.transparent, // 길게 탭할 때 번짐 컬러 제거 -> 현재 버전에선 차이 없음
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        // 앱바 테마 전역 설정
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black, // 글씨 색
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2, // Sizes.size18
              fontWeight: FontWeight.w600),
        ),
      ),
      home: const MainNavigationScreen(),
      // home: const InterestsScreen(),
    );
  }
}
