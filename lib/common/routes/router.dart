import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/screens/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/screens/login_screen.dart';
import 'package:tiktok_clone/features/authentication/screens/sign_up_screen.dart';
import 'package:tiktok_clone/features/inbox/screens/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/screens/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/screens/chat_screen.dart';
import 'package:tiktok_clone/features/onboarding/screens/interests_screen.dart';
import 'package:tiktok_clone/features/videos/views/screens/video_recording_screen.dart';

// go_router 전용
final router = GoRouter(
  initialLocation: '/inbox',
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      name: MainNavigationScreen.routeName,
      path: '/:tab(home|discover|inbox|profile)',
      builder: (context, state) {
        final tab = state.params['tab']!;
        return MainNavigationScreen(tab: tab);
      },
    ),
    GoRoute(
      name: ActivityScreen.routeName,
      path: ActivityScreen.routeURL,
      builder: (context, state) => const ActivityScreen(),
    ),
    GoRoute(
        name: ChatScreen.routeName,
        path: ChatScreen.routeURL,
        builder: (context, state) => const ChatScreen(),
        routes: [
          GoRoute(
            name: ChatDetailScreen.routeName,
            path: ChatDetailScreen.routeURL,
            builder: (context, state) {
              final chatId = state.params['chatId']!;
              return ChatDetailScreen(chatId: chatId);
            },
          )
        ]),
    GoRoute(
        name: VideoRecordingScreen.routeName,
        path: VideoRecordingScreen.routeURL,
        // builder: (context, state) => const VideoRecordingScreen(),
        // pageBuilder: 페이지 이동 시 커스덤 에니메이션 설정이 가능한 속성
        pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 200),
              child: const VideoRecordingScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final position = Tween(
                  begin: const Offset(0, 1), // 밑에서 위로
                  end: Offset.zero,
                ).animate(animation);
                return SlideTransition(position: position, child: child);
              },
            )),
  ],
);
