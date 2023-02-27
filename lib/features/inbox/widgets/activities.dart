import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/rawData/inboxes.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/utils/utils.dart';

class Activities extends StatelessWidget {
  final void Function(String) onDismissed;
  final bool showBarrier;
  final Animation<Color?> barrierAnimation;
  final VoidCallback toggleAnimations;
  final Animation<Offset> panelAnimation;

  const Activities({
    Key? key,
    required this.onDismissed,
    required this.showBarrier,
    required this.barrierAnimation,
    required this.toggleAnimations,
    required this.panelAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Stack(
      children: [
        ListView(
          // padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
              child: Text(
                'New',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            Gaps.v14,
            for (var notification in notifications)
              // Dismissible -> 자식을 옆으로 밀어 제거할 수 있는 기능 간단 적용
              Dismissible(
                key: Key(notification),
                onDismissed: (direction) => onDismissed(notification),
                background: Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.green,
                  child: const Padding(
                    padding: EdgeInsets.only(left: Sizes.size10),
                    child: FaIcon(
                      FontAwesomeIcons.checkDouble,
                      color: Colors.white,
                      size: Sizes.size32,
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.only(right: Sizes.size10),
                    child: FaIcon(
                      FontAwesomeIcons.trashCan,
                      color: Colors.white,
                      size: Sizes.size32,
                    ),
                  ),
                ),
                child: ListTile(
                  minVerticalPadding: Sizes.size16,
                  // contentPadding: EdgeInsets.zero, // 콘텐츠 패딩 제거
                  leading: Container(
                    width: Sizes.size52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? Colors.grey.shade800 : Colors.white,
                      border: Border.all(
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade400,
                        width: Sizes.size1,
                      ),
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.bell,
                      ),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: "Accounts updates:",
                      // RichText 기본 스타일
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isDark ? null : Colors.black,
                        fontSize: Sizes.size16,
                      ),
                      children: [
                        const TextSpan(
                          text: ' Upload longer videos',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: ' $notification',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: Sizes.size16,
                  ),
                ),
              ),
          ],
        ),
        // ListView 보다 뒤에 위치해야 배리어 효과 적용 가능
        if (showBarrier) // 배리어 제거 -> ListView 포인터 인식 가능
          AnimatedModalBarrier(
            color: barrierAnimation,
            dismissible: true, // 영역 클릭 시 사라짐 옵션 허용 -> onDismiss 와 연계해야 이벤트 작동
            onDismiss: toggleAnimations, // 사라질 때 실행할 콜백
          ),
        SlideTransition(
          position: panelAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(Sizes.size4),
                bottomRight: Radius.circular(Sizes.size4),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var tab in tabs)
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          tab['icon'],
                          size: Sizes.size16,
                        ),
                        Gaps.h20,
                        Text(
                          tab['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                Gaps.v16,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
