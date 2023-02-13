import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';

class AvatarForm extends StatelessWidget {
  const AvatarForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 24,
          foregroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/11626327?v=4'),
          child: Text('Hamdamboy'),
        ),
        Positioned(
          right: -3,
          bottom: -3,
          child: Container(
            width: Sizes.size20,
            height: Sizes.size20,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.green,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(Sizes.size10),
              ),
            ),
          ),
        )
      ],
    );
  }
}
