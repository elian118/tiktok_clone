import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 유저 프로필 생성
  Future<void> createProfile() async {
    // await _db.
  }
  // 프로필 가져오기
  // 프로필 수정 -> 분리
  // 아바타 수정
  // 바이오 수정
  // 링크 수정
}

final userRepo = Provider((ref) => UserRepository());
