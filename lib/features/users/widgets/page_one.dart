import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/utils/common_utils.dart';

class PageOne extends StatelessWidget {
  const PageOne({
    super.key,
    required this.viewItemCounts,
    required this.views,
  });

  final int viewItemCounts;
  final List<String> views;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        GridView.builder(
          // 다른 위젯 스크롤에만 반응하도록, 여기 스크롤은 방지
          physics: const NeverScrollableScrollPhysics(),
          // 스크롤 동안 키보드 감추기
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: viewItemCounts,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isWebScreen(context) ? 5 : 3,
            crossAxisSpacing: Sizes.size2,
            mainAxisSpacing: Sizes.size2,
            childAspectRatio: 9 / 14, // 그리드 비율
          ),
          itemBuilder: (context, index) {
            double calView = Random().nextDouble() * 10000;
            views.add(
                '${calView > 1000 ? (calView * 0.01).toStringAsFixed(1) : calView.toStringAsFixed(1)}${calView > 1000 ? 'M' : 'K'}');

            return Column(
              children: [
                AspectRatio(
                  aspectRatio: 9 / 14,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/flower-7696955.jpg',
                          image:
                              'https://cdn.pixabay.com/photo/2022/12/16/15/37/flower-7659988_960_720.jpg'),
                      Positioned(
                        left: Sizes.size8,
                        bottom: Sizes.size4,
                        child: Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.circlePlay,
                              size: Sizes.size14,
                              color: Colors.white,
                            ),
                            Gaps.h5,
                            Text(
                              views[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const Center(child: Text('Page two')),
      ],
    );
  }
}
