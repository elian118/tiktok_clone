import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/screens/email_screen.dart';
import 'package:tiktok_clone/features/authentication/screens/login_screen.dart';
import 'package:tiktok_clone/features/authentication/screens/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/screens/username_screen.dart';
import 'package:tiktok_clone/features/users/screens/user_profile_screen.dart';

// go_router 전용
final router = GoRouter(routes: [
  // nested routes 방식 -> /username/email
  GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
            name: UsernameScreen.routeName,
            path: UsernameScreen.routeURL,
            builder: (context, state) => const UsernameScreen(),
            routes: [
              GoRoute(
                name: EmailScreen.routeName,
                path: EmailScreen.routeURL,
                builder: (context, state) {
                  final args = state.extra as EmailScreenArgs;
                  return EmailScreen(username: args.username);
                },
              ),
            ]),
      ]),
  GoRoute(
    name: LoginScreen.routeName,
    path: LoginScreen.routeURL,
    builder: (context, state) => const LoginScreen(),
  ),
  // GoRoute(
  //   // name: path 속성값 대신 url 대상으로 참조할 수 있는 name
  //   name: 'username_screen', // context.pushNamed(location, extra: extra);
  //   path: UsernameScreen.routeName, // context.push(location, extra: extra);
  //   // 페이지 이동 애니메이션 설정 시 builder 대신 pageBuilder 사용
  //   pageBuilder: (context, state) {
  //     // CustomTransitionPage -> 기본 애니메이션 설정이 박혀있는 위젯
  //     return CustomTransitionPage(
  //       child: const UsernameScreen(),
  //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //         return FadeTransition(
  //           opacity: animation,
  //           child: ScaleTransition(scale: animation, child: child),
  //         );
  //       },
  //     );
  //   },
  // ),
  GoRoute(
    path: '/users/:username',
    builder: (context, state) {
      final username = state.params['username'];
      final tab = state.queryParams['show'];
      return UserProfileScreen(username: username!, tab: tab!);
    },
  ),
]);
