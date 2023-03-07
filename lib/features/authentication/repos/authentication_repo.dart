import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  // 간편 파이어베이스 인증 설정 -> FirebaseAuth.instance 만 가져오면 모든 초기화 끝
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;

  // 유저 로그인 상태 변경
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<void> emailSignUp(String email, String password) {
    // 파이어베이스로 이메일 회원가입 요청(이메일, 비밀번호 필수)
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // 로그아웃
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());

final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
