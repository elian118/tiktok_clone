import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/sign_up/sign_up_screen.dart';

void main() {
  runApp(const TickTokApp());
}

class TickTokApp extends StatelessWidget {
  const TickTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TickTok Clone',
      theme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
      ),
      home: const SignUpScreen(),
    );
  }
}
