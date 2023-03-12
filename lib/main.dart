import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/routes/router.dart';
import 'package:tiktok_clone/features/videos/repos/playback_config_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/styles/text_theme.dart';

import 'firebase_options.dart';

void main() async {
  // runApp() 실행 전에 위젯 바인딩을 먼저
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final preferences =
      await SharedPreferences.getInstance(); // 기기 저장소 사용을 위한 공유 기본설정 불러오기(싱글톤)
  final repository =
      PlaybackConfigRepository(preferences); // 기기 저장소와 리포지토리 클래스 연결

  runApp(ProviderScope(overrides: [
    playbackConfigProvider.overrideWith(
        () => PlaybackConfigViewModel(repository)) // 기기 저장소 연동 설정 오버라이드
  ], child: const TickTokApp()));
}

class TickTokApp extends ConsumerWidget {
  const TickTokApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 강제로 언어설정 바꾸기
    // S.load(const Locale('en'));
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'TikTok Clone',
      // 번역 설정
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko'), // 한국어. kr로 절대 쓰지 말 것
        Locale('en'), // 영어
        Locale('es'), // 스페인어
      ],
      // themeMode: ThemeMode.system, // 다크/라이트 모드 - ThemeMode.system -> 시스템 설정에 따름
      themeMode: ref.watch(playbackConfigProvider).darkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      // 전역 테마 설정
      theme: ThemeData(
        useMaterial3: true, // 매터리얼3 스타일 이관 여부
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
          surfaceTintColor: Colors.white,
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
        ),
        iconTheme: IconThemeData(
          color: Colors.grey.shade900,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
        ),
      ),
      // 다크모드 테마
      darkTheme: ThemeData(
        useMaterial3: true, // 매터리얼3 스타일 이관 여부
        brightness: Brightness.dark, // 기본 밝기 - 다크 모드에 따름 -> 텍스트 컬러 자동 반전
        // textTheme: textTheme,
        textTheme: textTheme3dark,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFE9435A),
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.grey.shade900,
          backgroundColor: Colors.grey.shade900,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size16 + Sizes.size2, // Sizes.size18
            fontWeight: FontWeight.w600,
          ),
          actionsIconTheme: IconThemeData(color: Colors.grey.shade100),
          iconTheme: IconThemeData(color: Colors.grey.shade100),
        ),
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade900),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade700,
        ),
        iconTheme: IconThemeData(
          color: Colors.grey.shade500,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
        ),
      ),
    );
  }
}
