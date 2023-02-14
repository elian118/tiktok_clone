import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';

class AutoCompleteForm extends StatelessWidget {
  final Widget content;

  const AutoCompleteForm({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size4),
      child: FittedBox(
        alignment: Alignment.center,
        child: Container(
          height: Sizes.size32,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size14,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(
              Sizes.size16,
            ),
          ),
          child: content,
        ),
      ),
    );
  }
}
