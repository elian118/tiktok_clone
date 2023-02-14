import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/rawData/foreground_image.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
        slivers: [
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
                // Flexible 위젯도 고려해볼 수 있다.
                FractionallySizedBox(
                  widthFactor: 0.33, // 부모 너비 기준
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.grey.shade200,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: const TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                    ),
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    tabs: [
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
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    children: [
                      GridView.builder(
                        // 다른 위젯 스크롤에만 반응하도록, 여기 스크롤은 방지
                        physics: const NeverScrollableScrollPhysics(),
                        // 스크롤 동안 키보드 감추기
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: 20,
                        padding: const EdgeInsets.all(Sizes.size6),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: Sizes.size10,
                          mainAxisSpacing: Sizes.size10,
                          childAspectRatio: 9 / 20, // 그리드 비율
                        ),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size4),
                              ),
                              child: AspectRatio(
                                aspectRatio: 9 / 16,
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  placeholder:
                                      'assets/images/windmill-7367963.jpg',
                                  image:
                                      "https://cdn.pixabay.com/photo/2023/01/24/13/23/viet-nam-7741017_960_720.jpg",
                                ),
                              ),
                            ),
                            Gaps.v10,
                            const Text(
                              "This is a very long caption for my tiktok that i'm upload just now currently.",
                              style: TextStyle(
                                fontSize: Sizes.size18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Gaps.v8,
                            DefaultTextStyle(
                              style: TextStyle(
                                fontSize: Sizes.size14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 15,
                                    foregroundImage:
                                        NetworkImage(foregroundImage),
                                  ),
                                  Gaps.h4,
                                  const Expanded(
                                    child: Text(
                                      'My avatar is going to be very long',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Gaps.h4,
                                  FaIcon(
                                    FontAwesomeIcons.heart,
                                    size: Sizes.size16,
                                    color: Colors.grey.shade600,
                                  ),
                                  Gaps.h2,
                                  const Text(
                                    '2.5M',
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Center(child: Text('Page two')),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
