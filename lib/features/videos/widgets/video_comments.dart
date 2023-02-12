import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils/utils.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({Key? key}) : super(key: key);

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onClosePressed() {
    Utils.navPop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge, // borderRadius 나머지 여백을 모조리 제거
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size14,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          automaticallyImplyLeading: false, // 기본 좌상단 이동 화살표 제거
          title: const Text('22796 comments'),
          // 우상단 액션 버튼 설정
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size8,
            horizontal: Sizes.size16,
          ),
          itemCount: 10,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 18,
                  child: Text('광회'),
                ),
                Gaps.h10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '광회',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Sizes.size14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      Gaps.v3,
                      const Text(
                        "That's not it l've seen the same thing but also in a cave. That's not it l've seen the same thing but also in a cave. That's not it l've seen the same thing but also in a cave",
                      ),
                    ],
                  ),
                ),
                Gaps.h10,
                Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.heart,
                      size: Sizes.size20,
                      color: Colors.grey.shade500,
                    ),
                    Gaps.v2,
                    Text(
                      '52.2K',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
              vertical: Sizes.size10,
            ),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 18,
                  foregroundColor: Colors.white,
                  child: Text('광회'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
