import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/constants/enums/breakpoints.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/web_container.dart';
import 'package:tiktok_clone/features/users/widgets/user_profile_body.dart';
import 'package:tiktok_clone/features/users/widgets/user_profile_header.dart';
import 'package:tiktok_clone/utils/utils.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isWebScreen(context)
        ? WebContainer(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size96),
            maxWidth: Breakpoint.md,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                UserProfileHeader(),
                UserProfileBody(),
              ],
            ),
          )
        : Column(
            children: const [
              UserProfileHeader(),
              Gaps.v14,
              // 부모 위젯 크기에 따른 상대적 사이즈를 지정할 수 있는 Box 위젯
              // 부모 대비 높이(heightFactor), 너비(widthFactor)
              UserProfileBody(),
              Gaps.v20,
            ],
          );
  }
}
