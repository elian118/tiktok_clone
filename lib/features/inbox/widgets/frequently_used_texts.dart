import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/auto_complete_form.dart';
import 'package:tiktok_clone/utils/common_utils.dart';

class FrequentlyUsedTexts extends StatelessWidget {
  const FrequentlyUsedTexts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWinWidth(context) - 30,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoCompleteForm(
              content: Text(
                '❤️❤️❤️',
                style: TextStyle(
                  fontSize: Sizes.size20,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            AutoCompleteForm(
              content: Text(
                '😂😂😂',
                style: TextStyle(
                  fontSize: Sizes.size20,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            AutoCompleteForm(
              content: Text(
                '👍👍👍',
                style: TextStyle(
                  fontSize: Sizes.size20,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            AutoCompleteForm(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.googlePlay,
                    size: Sizes.size16,
                    color: Colors.grey.shade800,
                  ),
                  Gaps.h5,
                  Text(
                    'Share post',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
