import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/auto_complete_form.dart';

class FrequentlyUsedTexts extends StatelessWidget {
  const FrequentlyUsedTexts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: Wrap(
        spacing: Sizes.size10,
        runSpacing: Sizes.size15,
        children: [
          const AutoCompleteForm(
            content: Text(
              '❤️❤️❤️',
              style: TextStyle(
                fontSize: Sizes.size20,
              ),
            ),
          ),
          const AutoCompleteForm(
            content: Text(
              '😂😂😂',
              style: TextStyle(
                fontSize: Sizes.size20,
              ),
            ),
          ),
          const AutoCompleteForm(
            content: Text(
              '👍👍👍',
              style: TextStyle(
                fontSize: Sizes.size20,
              ),
            ),
          ),
          AutoCompleteForm(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FaIcon(
                  FontAwesomeIcons.googlePlay,
                  size: Sizes.size16,
                ),
                Gaps.h5,
                Text(
                  'Share post',
                  style: TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
