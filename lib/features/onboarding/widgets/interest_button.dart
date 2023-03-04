import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/utils/common_utils.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    super.key,
    required this.interest,
  });

  final String interest;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          color: _isSelected
              ? Theme.of(context).primaryColor
              : isDarkMode(context)
                  ? Colors.grey.shade700
                  : Colors.white,
          borderRadius: BorderRadius.circular(Sizes.size32),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5, // 둘레 번짐
              spreadRadius: 5, // 둘레 퍼짐
            )
          ],
        ),
        child: Text(
          widget.interest,
          style: TextStyle(
            fontSize: 16,
            color: _isSelected
                ? Colors.white
                : isDarkMode(context)
                    ? Colors.grey.shade500
                    : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
