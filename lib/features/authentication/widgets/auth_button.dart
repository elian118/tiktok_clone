import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  const AuthButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 부모 위젯 크기에 따른 상대적 사이즈를 지정할 수 있는 Box 위젯
    return FractionallySizedBox(
      widthFactor: 1, // 부모 위젯 크기를 1로 설정
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size14),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade200,
            width: Sizes.size1,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
