import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/common/constants/rawData/foreground_image.dart';

class Avatar extends ConsumerWidget {
  final String name;
  const Avatar(this.name, {Key? key}) : super(key: key);

  Future<void> _onAvatarTab() async {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxWidth: 150,
      maxHeight: 150,
    );
    if (xFile != null) {
      final file = File(xFile.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: _onAvatarTab,
      child: CircleAvatar(
        radius: 50,
        foregroundColor: Colors.teal,
        foregroundImage: const NetworkImage(foregroundImage),
        child: Text(name),
      ),
    );
  }
}
