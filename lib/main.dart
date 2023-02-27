import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/screens/main_navigation_screen.dart';
import 'package:tiktok_clone/styles/text_theme.dart';

void main() async {
  /*
  runApp() 보다 앞서 실행될 아래 코드들은 애플리케이션 실행 환경을 커스더마이징할 목적에서 작성되며,
   모두 바인딩 초기화 이후에만 설정이 가능하다.

  1. runApp(app) 호출 전에 바인딩 초기화
  // WidgetsFlutterBinding.ensureInitialized();

  2. 선호하는 기기 해상도 설정 -> 복수 설정 가능
  await SystemChrome.setPreferredOrientations(
    [
      // 세로 모드(portraitUp) 하나만 설정하면, 폰을 가로 놓아도 화면전환이 되지 않는다.
      DeviceOrientation.portraitUp,
      ...
    ],
  );

  3. OS UI 스타일 설정
  // SafeArea 안에 위치하는 UI를 고정된 light 모드로 전환 -> 흰 바탕이면 글씨가 안 보이게 됨
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
      themeMode: ThemeMode.system, // 다크/라이트 모드 - ThemeMode.system -> 시스템 설정에 따름
      // 전역 테마 설정
      theme: ThemeData(
          brightness: Brightness.light, // 기본 밝기 - 라이트 모드에 따름
          // textTheme: textTheme,
          textTheme: textTheme3,
          scaffoldBackgroundColor: Colors.white, // 스카폴드 배경
          // bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade50),
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
              fontWeight: FontWeight.w600,
            ),
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
          )),
      // 다크모드 테마
      darkTheme: ThemeData(
          brightness: Brightness.dark, // 기본 밝기 - 다크 모드에 따름 -> 텍스트 컬러 자동 반전
          // textTheme: textTheme,
          textTheme: textTheme3dark,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0xFFE9435A),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade900,
          ),
          bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade900),
          tabBarTheme: const TabBarTheme(indicatorColor: Colors.white)),
      // home: const SignUpScreen(),
      home: const MainNavigationScreen(),
      // home: const LayoutBuilderCodeLab(), // 메인레이아웃 위젯 역할 확인
      // home: const ActivityScreen(),
      // home: const InterestsScreen(),
      // home: const TutorialScreen(),
    );
  }
}

// 반응형 로직 확인을 위한 예시 위젯
class LayoutBuilderCodeLab extends StatelessWidget {
  const LayoutBuilderCodeLab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width / 2,
        // LayoutBuilder -> 자식 위젯의 최대 크기 정보를 알 수 있다.
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: Colors.teal,
            child: Center(
              child: Text(
                '${constraints.maxWidth} / ${size.width}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 98,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
