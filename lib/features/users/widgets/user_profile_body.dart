import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 450,
          child: FractionallySizedBox(
            widthFactor: 0.66,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size14,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    child: const Text(
                      'Follow',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size11,
                      horizontal: Sizes.size9,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(
                        Sizes.size4,
                      ),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.youtube,
                      size: Sizes.size22,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size16,
                      vertical: Sizes.size14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.caretDown,
                      size: Sizes.size16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Gaps.v14,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
          child: Text(
            'All highlights and where to watch live matches on FIFA+',
            textAlign: TextAlign.center,
          ),
        ),
        Gaps.v14,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FaIcon(
              FontAwesomeIcons.link,
              size: Sizes.size12,
            ),
            Text(
              '@ https://www.fifa.com/fifaplus/en/home',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.h4,
          ],
        ),
      ],
    );
  }
}
