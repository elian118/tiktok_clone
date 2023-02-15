import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/rawData/foreground_image.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        // NestedScrollView -> CustomScrollView 보다 간편하게 유형별로 규격화된 스크롤뷰 중 하나로,
        //  바디에 또 다른 스크롤 뷰 위젯을 여럿 배치할 수 있는 포맷이다.
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: const Text('Profile'),
              actions: [
                IconButton(
                  onPressed: () => print('dd'),
                  icon: const FaIcon(FontAwesomeIcons.gear),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    foregroundColor: Colors.teal,
                    foregroundImage: NetworkImage(foregroundImage),
                    child: Text('광회'),
                  ),
                  Gaps.v20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '@광회',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.size18,
                        ),
                      ),
                      Gaps.h5,
                      FaIcon(
                        FontAwesomeIcons.solidCircleCheck,
                        color: Colors.blue.shade500,
                        size: Sizes.size16,
                      ),
                    ],
                  ),
                  Gaps.v24,
                  SizedBox(
                    height: Sizes.size48, // VerticalDivider 표시를 위한 설정
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text(
                              '37',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size18,
                              ),
                            ),
                            Gaps.v3,
                            Text(
                              'Following',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                        // 구분선은 부모의 높이와 너비 설정이 있을 때만 보임
                        VerticalDivider(
                          color: Colors.grey.shade400,
                          thickness: Sizes.size1,
                          width: Sizes.size32,
                          indent: Sizes.size14,
                          endIndent: Sizes.size14,
                        ),
                        Column(
                          children: [
                            const Text(
                              '10.5M',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size18,
                              ),
                            ),
                            Gaps.v3,
                            Text(
                              'Followers',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.grey.shade400,
                          thickness: Sizes.size1,
                          width: Sizes.size32,
                          indent: Sizes.size14,
                          endIndent: Sizes.size14,
                        ),
                        Column(
                          children: [
                            const Text(
                              '149.3M',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size18,
                              ),
                            ),
                            Gaps.v3,
                            Text(
                              'Likes',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gaps.v14,
                  // 부모 대비 높이(heightFactor), 너비(widthFactor) 지정값을 갖는 박스
                  FractionallySizedBox(
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
                  Gaps.v20,
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: PersistentTabBar(),
            ),
          ],
          body: TabBarView(
            children: [
              GridView.builder(
                // 다른 위젯 스크롤에만 반응하도록, 여기 스크롤은 방지
                physics: const NeverScrollableScrollPhysics(),
                // 스크롤 동안 키보드 감추기
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: 20,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: Sizes.size2,
                  mainAxisSpacing: Sizes.size2,
                  childAspectRatio: 9 / 14, // 그리드 비율
                ),
                itemBuilder: (context, index) => Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 14,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: 'assets/images/windmill-7367963.jpg',
                            image:
                                "https://cdn.pixabay.com/photo/2023/01/24/13/23/viet-nam-7741017_960_720.jpg",
                          ),
                          Positioned(
                            left: Sizes.size8,
                            bottom: Sizes.size4,
                            child: Row(
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.circlePlay,
                                  size: Sizes.size14,
                                  color: Colors.white,
                                ),
                                Gaps.h5,
                                Text(
                                  '4.1M',
                                  style: TextStyle(
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
                ),
              ),
              const Center(child: Text('Page two')),
            ],
          ),
        ),
      ),
    );
  }
}
