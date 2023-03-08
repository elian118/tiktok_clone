import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';

class SuffixIcons extends StatelessWidget {
  final bool obscureText;
  final void Function()? onClearTap;
  final void Function()? toggleObscureText;

  const SuffixIcons({
    Key? key,
    required this.obscureText,
    this.onClearTap,
    this.toggleObscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // 자식들을 맨 뒤로 보내기 위한 최소값 설정
      children: [
        GestureDetector(
          onTap: onClearTap,
          child: FaIcon(
            FontAwesomeIcons.solidCircleXmark,
            color: Colors.grey.shade500,
            size: Sizes.size20,
          ),
        ),
        Gaps.h16,
        GestureDetector(
          onTap: toggleObscureText,
          child: FaIcon(
            obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
            color: Colors.grey.shade500,
            size: Sizes.size20,
          ),
        ),
      ],
    );
  }
}
