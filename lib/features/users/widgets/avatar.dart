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

  Future<void> _onAvatarTab(WidgetRef ref) async {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40, // 이미지 품질 40% -> 용량 줄이기
      maxWidth: 150,
      maxHeight: 150,
    );
    if (xFile != null) {
      final file = File(xFile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap:
          isLoading ? null : () => _onAvatarTab(ref), // ConsumerWidget > ref 전달
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
              foregroundColor: Colors.teal,
              // %2F : '/'를 파싱한 부분 -> 위치상 여기 이후부터 쿼리스트링 시작 전('?' 앞)까지가 uid
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/tiktok-clone-elian.appspot.com/o/avatars%2F$uid?alt=media&token=c7dafac2-66b0-49a7-8628-2f57ff748084')
                  : null,
              child: Text(name),
            ),
    );
  }
}
