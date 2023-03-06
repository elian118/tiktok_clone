import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/screens/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/screens/login_screen.dart';
import 'package:tiktok_clone/features/authentication/screens/sign_up_screen.dart';
import 'package:tiktok_clone/features/inbox/screens/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/screens/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/screens/chat_screen.dart';
import 'package:tiktok_clone/features/onboarding/screens/interests_screen.dart';
import 'package:tiktok_clone/features/videos/views/screens/video_recording_screen.dart';

// riverPod 전용
final routerProvider = Provider(
  // ref 인자를 모든 라우터에 전달 => 여기는 물론, 모든 라우터에서 ref 로 전역 state 접근 가능
  (ref) => GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        // state.subloc -> 스테이트의 서브 로케이션 -> e.g. /family/f2
        //  로그인도 안 한채 특정 페이지 진입 시도 시 홈화면으로 강제 리다이렉션
        if (state.subloc != SignUpScreen.routeURL &&
            state.subloc != LoginScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
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
  ),
);
