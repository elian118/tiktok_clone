import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadVideoFile(File video, String uid) {
    final fileRef = _storage.ref().child(
        '/videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}');
    return fileRef.putFile(video);
  }

  // 비디오 파일 업로드 및 비디오 문서 생성
  Future<void> saveVideo(VideoModel data) async {
    await _db.collection('videos').add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos(
      {int? lastItemCreatedAt}) async {
    final query = _db
        .collection("videos")
        .orderBy("createdAt", descending: true) // 생성일자 내림차순 정렬
        .limit(2); // 조회된 데이터 중 두 개만 가져온다. -> 1, 2

    return lastItemCreatedAt == null
        ? await query.get()
        : await query.startAfter([
            lastItemCreatedAt
          ]).get(); // lastItemCreatedAt 다음부터 조회된 데이터 두 개 반환  -> 3, 4
  }
}

final videosRepo = Provider((ref) => VideosRepository());
