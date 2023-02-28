import 'package:tiktok_clone/features/authentication/screens/email_screen.dart';
import 'package:tiktok_clone/features/authentication/screens/login_screen.dart';
import 'package:tiktok_clone/features/authentication/screens/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/screens/username_screen.dart';

final namedRoutes = {
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  UsernameScreen.routeName: (context) => const UsernameScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  EmailScreen.routeName: (context) => const EmailScreen(),
};
