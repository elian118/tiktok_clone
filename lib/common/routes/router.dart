import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/screens/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/screens/login_screen.dart';
import 'package:tiktok_clone/features/authentication/screens/sign_up_screen.dart';
import 'package:tiktok_clone/features/onboarding/screens/interests_screen.dart';

// go_router 전용
final router = GoRouter(
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
  ],
);
