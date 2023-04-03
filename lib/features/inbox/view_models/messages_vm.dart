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
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _repo.sendMessage(message);
    });
  }
}

final messagesProvider =
    AsyncNotifierProvider<MessagesViewModel, void>(() => MessagesViewModel());

// autoDispose -> 화면을 나가면 자동으로 프로버이더를 메모리에서 제거.
//  chatProvider 는 플러터에서 자동 관리되지 않는 독립 클래스이므로,
//    채팅방을 들어갈 때마다 생성되고 event listen 하게 된다.
//  따라서, autoDispose 로 자동제거하지 않으면 채팅방을 나가도 계속 해서 event listen 상태가 유지돼 버린다.
//  즉, 다른 채팅방을 들어가도 계속 해당 채팅방 이벤트 청취상태를 유지한다는 의미 => 시스템 자원 낭비
final chatProvider = StreamProvider.autoDispose<List<MessageModel>>((ref) {
  final db = FirebaseFirestore.instance;

  return db
      .collection('chat_rooms')
      .doc('drq8uCHF4SPWZnTpn59J')
      .collection('texts')
      .orderBy('createdAt')
      .snapshots() // 스트림 리턴 => 실시간 백엔드 데이터 변경사항 반환
      .map(
        (event) => event.docs
            .map((doc) => MessageModel.fromJson(
                doc.data())) // 쿼리 스냅샷을 ChatDetailScreen 에서 쓸 수 있도록 가공
            .toList()
            // 역순으로 바꾸고 싶을 경우 아래 코드 활성화 -> ListView.separated(reverse: true...)
            .reversed
            .toList(),
      );
});
