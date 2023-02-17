import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/settings/screens/setting_screen.dart';
import 'package:tiktok_clone/features/users/widgets/page_one.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_info.dart';
import 'package:tiktok_clone/utils/utils.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<String> views = [];
  int viewItemCounts = 20;

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
                  onPressed: () =>
                      Utils.navPush(context, const SettingScreen()),
                  icon: const FaIcon(FontAwesomeIcons.gear),
                ),
              ],
            ),
            const SliverToBoxAdapter(
              child: UserInfo(),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: PersistentTabBar(),
            ),
          ],
          body: PageOne(viewItemCounts: viewItemCounts, views: views),
        ),
      ),
    );
  }
}
