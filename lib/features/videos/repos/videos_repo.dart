import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_like_model.dart';
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

  Future<VideoLikeModel> isLiked(String videoId, String userId) async {
    final likeQuery = _db.collection("likes").doc("${videoId}000$userId");
    final videoQuery = _db.collection("videos").doc(videoId);

    final like = await likeQuery.get();
    final video = await videoQuery.get();
    final videoData = video.data();

    final VideoModel vm =
        VideoModel.fromJson(json: videoData!, videoId: videoId);

    return VideoLikeModel(isLikeVideo: like.exists, likeCount: vm.likes);
  }

  Future<bool> likeVideo(String videoId, String userId) async {
    // 파이어베이스에 SQL 사용 -> 값비싼 비용 치러야 하므로, 아래와 같은 편법을 동원한다.
    // 새로운 컬랙션 생성 -> videoId + 000 + userId
    final query = _db.collection("likes").doc("${videoId}000$userId");
    final like = await query.get();

    // 고유 videoId + 000 + userId 컬랙션이 존재한다면 -> 좋아요를 이미 누른 것이다
    //  아직 좋아요를 누르지 않은 영상만 좋아요 처리
    if (!like.exists) {
      await query.set({
        "createdAt": DateTime.now().millisecondsSinceEpoch,
      });
      return false;
    } else {
      await query.delete();
      return true;
    }
  }
}

final videosRepo = Provider((ref) => VideosRepository());
