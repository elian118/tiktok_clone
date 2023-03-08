import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
  // 아바타 등록
  Future<void> uploadAvatar(File file, String fileName) async {
    // 파이어스토리지 파일 저장 위치 및 파일 지정
    final fileRef = _storage.ref().child('avatars/$fileName');
    fileRef.putFile(file);
  }
  // 바이오 수정
  // 링크 수정
}

final userRepo = Provider((ref) => UserRepository());
