import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class BirthdayHeader extends StatelessWidget {
  const BirthdayHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "When's your birthday?",
                style: TextStyle(
                  fontSize: Sizes.size22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v8,
              Text(
                "Your birthday won't be shown publicly.",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child:
              // Image.asset(
              //   'assets/images/cake_img.png',
              // ),
              FittedBox(
            alignment: Alignment.centerRight,
            fit: BoxFit.fitHeight,
            child: Image.asset(
              'assets/images/cake_img.png',
            ),
          ),
        )
      ],
    );
  }
}
