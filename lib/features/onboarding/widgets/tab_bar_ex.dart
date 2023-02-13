import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';

class TabBarEx extends StatelessWidget {
  const TabBarEx({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 탭 수 지정
      child: Scaffold(
        body: SafeArea(
          // TabBarView 컨트롤러는 아래와 같이 설정한다.
          // 1) controller 속성을 직접 설정
          // 2) DefaultTabController 위젯을 화면 상단에 랩핑해 증손자(TabBarView)에게 컨트롤러를 주입
          child: TabBarView(
            // controller: ,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Gaps.v52,
                    Text(
                      'Watch cool videos!',
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v20,
                    Text(
                      'Videos are personalized for you based on what you watch, like, and share.',
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Gaps.v52,
                    Text(
                      'Follow the rules!',
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v20,
                    Text(
                      'Videos are personalized for you based on what you watch, like, and share.',
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Gaps.v52,
                    Text(
                      'Enjoy the ride!',
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v20,
                    Text(
                      'Videos are personalized for you based on what you watch, like, and share.',
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                TabPageSelector(
                  color: Colors.white,
                  selectedColor: Colors.black54,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
