import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/utils/common_utils.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isDark = isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
        labelPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        tabs: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Icon(Icons.grid_4x4_rounded),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: FaIcon(FontAwesomeIcons.heart),
          ),
        ],
      ),
    );
  }

  /*
  maxExtent, minExtent 값이 실제 그려질 크기를 초과할 경우 예외 발생
  다트 콘솔 예외 메시지를 확인하고 요구되는 수치를 직접 입력

  SliverGeometry is not valid: The "layoutExtent" exceeds the "paintExtent".

  The paintExtent is 47.0, but the layoutExtent is 200.0.
  */
  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
