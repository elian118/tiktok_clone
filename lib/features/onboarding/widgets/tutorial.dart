import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';

class Tutorial extends StatelessWidget {
  final String mainText;
  final String subText;

  const Tutorial({
    super.key,
    required this.mainText,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v80,
        Text(
          mainText,
          style: const TextStyle(
            fontSize: Sizes.size40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v20,
        Text(
          subText,
          style: const TextStyle(
            fontSize: Sizes.size20,
          ),
        ),
      ],
    );
  }
}
