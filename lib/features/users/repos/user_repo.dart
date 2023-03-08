import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 유저 프로필 생성
  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection('users').doc(profile.uid).set(profile.toJson());
  }

  // 프로필 가져오기
  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data();
  }

  // 프로필 수정 -> 분리
  // 아바타 수정
  // 바이오 수정
  // 링크 수정
}

final userRepo = Provider((ref) => UserRepository());
