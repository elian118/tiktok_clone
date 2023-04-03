import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';
import 'package:tiktok_clone/features/inbox/repos/messages_repo.dart';

class MessagesViewModel extends AsyncNotifier<void> {
  late final MessagesRepository _repo;

  @override
  FutureOr build() {
    _repo = ref.read(messagesRepo);
  }

  Future<void> sendMessage(String text) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final message = MessageModel(
        text: text,
        userId: user!.uid,
        createAt: DateTime.now().millisecondsSinceEpoch,
      );
      _repo.sendMessage(message);
    });
  }
}

final messagesProvider =
    AsyncNotifierProvider<MessagesViewModel, void>(() => MessagesViewModel());

final chatProvider = StreamProvider<List<MessageModel>>((ref) {
  final db = FirebaseFirestore.instance;

  return db
      .collection('chat_rooms')
      .doc('drq8uCHF4SPWZnTpn59J')
      .collection('texts')
      .orderBy('createdAt')
      .snapshots() // 스트림 리턴 => 실시간 백엔드 데이터 변경사항 반환
      .map((event) => event.docs
          .map((doc) =>
              MessageModel.fromJson(doc.data())) // 쿼리 스냅샷을 VM 에서 쓸 수 있도록 가공
          .toList());
});
