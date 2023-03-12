import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/settings/screens/setting_screen.dart';
import 'package:tiktok_clone/features/users/view_models/profile_state_notifier.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/widgets/page_one.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_info.dart';
import 'package:tiktok_clone/utils/route_utils.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen({
    Key? key,
    required this.username,
    required this.tab,
  }) : super(key: key);

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  List<String> views = [];
  int viewItemCounts = 20;

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == 'likes' ? 1 : 0,
                length: 2,
                // NestedScrollView -> CustomScrollView 보다 간편하게 유형별로 규격화된 스크롤뷰 중 하나로,
                //  바디에 또 다른 스크롤 뷰 위젯을 여럿 배치할 수 있는 포맷이다.
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      centerTitle: true,
                      title: Text(data.name),
                      // backgroundColor: isDark ? Colors.black : null,
                      actions: [
                        IconButton(
                            onPressed: () => ref
                                .read(editProvider.notifier)
                                .setValue("isEditMode",
                                    !ref.read(editProvider)['isEditMode']),
                            icon: FaIcon(!ref.watch(editProvider)["isEditMode"]
                                ? FontAwesomeIcons.pen
                                : FontAwesomeIcons.eye)),
                        IconButton(
                          onPressed: () =>
                              navPush(context, const SettingScreen()),
                          icon: const FaIcon(FontAwesomeIcons.gear),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: UserInfo(
                        username: data.name,
                        hasAvatar: data.hasAvatar,
                        uid: data.uid,
                        bio: data.bio,
                        link: data.link,
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: PersistentTabBar(),
                    ),
                  ],
                  body: PageOne(viewItemCounts: viewItemCounts, views: views),
                ),
              ),
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(), // 현재 기기에 맞는 로딩 아아콘 표시
          ),
        );
  }
}
