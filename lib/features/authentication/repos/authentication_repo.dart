import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  // 간편 파이어베이스 인증 설정 -> FirebaseAuth.instance 만 가져오면 모든 초기화 끝
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;
}

final authRepo = Provider((ref) => AuthenticationRepository());
