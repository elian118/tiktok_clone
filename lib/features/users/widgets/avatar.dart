import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/features/users/view_models/avatar_view_model.dart';

class Avatar extends ConsumerWidget {
  final String name;
  final bool hasAvatar;
  final String uid;

  const Avatar({
    Key? key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
  }) : super(key: key);

  Future<void> _onAvatarTab(BuildContext context, WidgetRef ref) async {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40, // 이미지 품질 40% -> 용량 줄이기
      maxWidth: 150,
      maxHeight: 150,
    );
    if (xFile != null) {
      final file = File(xFile.path);
      // if (!mounted) return;
      ref.read(avatarProvider.notifier).uploadAvatar(context, file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: isLoading
          ? null
          : () => _onAvatarTab(context, ref), // ConsumerWidget > ref 전달
      child: isLoading
          ? Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(),
            )
          : CircleAvatar(
              radius: 50,
              // %2F : '/'를 파싱한 부분 -> 위치상 여기 이후부터 쿼리스트링 시작 전('?' 앞)까지가 uid
              foregroundImage: hasAvatar
                  // NetworkImage 는 주소가 바뀌지 않으면 이미지도 바꾸지 않는다. -> 아바타 이미지를 업뎃해도 화면에서 변경 안 되는 이유
                  ? NetworkImage(
                      // 의미 없는 haha 쿼리스트링을 추가해 NetworkImage 가 새로운 url 로 착각하도록 속인다.(참고: 토큰 정보 지움: 지워도 이미지 로드 문제 없고, 없어야 로딩이 보임) -> 이미지 갱신 유도
                      'https://firebasestorage.googleapis.com/v0/b/tiktok-clone-elian.appspot.'
                      'com/o/avatars%2F$uid?alt=media&haha=${DateTime.now().toString()}')
                  : null,
              child: Text(name),
            ),
    );
  }
}
