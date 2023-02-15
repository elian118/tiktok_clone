import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/screens/main_navigation_screen.dart';

void main() async {
  // runApp(app) 호출 전에 바인딩 초기화
  // WidgetsFlutterBinding.ensureInitialized();

  // runApp() 이전 실행될 아래 코드들은 바인딩 초기화 이후에만 설정 가능
  /*
  // 선호하는 기기 해상도 설정 -> 바인딩 초기화 이후 설정 가능 가능
  await SystemChrome.setPreferredOrientations(
    [
      // 세로 모드 -> 하나만 설정한 경우, 스마트폰을 가로로 놓아도 화면전환이 되지 않는다.
      DeviceOrientation.portraitUp,
    ],
  );

  // SafeArea 안에 위치하는 UI를 라이트 모드로 바꾼다. -> 흰 바탕이면 글씨가 안 보이게 됨
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  */

  runApp(const TickTokApp());
}

class TickTokApp extends StatelessWidget {
  const TickTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      // home: const SignUpScreen(),
      // home: const ActivityScreen(),
      // home: const InterestsScreen(),
    );
  }
}
