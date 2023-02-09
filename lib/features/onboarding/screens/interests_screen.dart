import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/rawData/interests.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/onboarding/screens/tutorial_screen.dart';
import 'package:tiktok_clone/features/onboarding/widgets/interest_button.dart';
import 'package:tiktok_clone/utils/utils.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _showTitle = false;

  void _onScroll() {
    // 과도한 setState() 호출 방지
    if (_scrollController.offset > 100 && _showTitle) return;
    setState(() => _showTitle = _scrollController.offset > 100);
    // test
    // print(_scrollController.offset); // 스크롤 시 변경된 오프셋 위치정보 실시간 표시
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
            opacity: _showTitle ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: const Text('Choose your interests')),
      ),
      // 스크롤바를 보고 싶을 때 Scrollbar 랩핑
      // -> 단, 컨트롤러가 자식인 SingleChildScrollView 의 것과 동일해야 한다.
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(
                left: Sizes.size24, right: Sizes.size24, bottom: Sizes.size16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                const Text(
                  'Choose your interests',
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                const Text(
                  'Get better video recommendations',
                  style: TextStyle(
                    fontSize: Sizes.size20,
                  ),
                ),
                Gaps.v40,
                // Grid 유사 위젯
                Wrap(
                  spacing: Sizes.size15,
                  runSpacing: Sizes.size15,
                  children: [
                    for (var interest in interests)
                      InterestButton(interest: interest)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.size16,
            bottom: Sizes.size40,
            left: Sizes.size24,
            right: Sizes.size24,
          ),
          // CupertinoButton 또는 TextButton 위젯 사용
          child: CupertinoButton(
            onPressed: () => Utils.navPush(context, const TutorialScreen()),
            color: Theme.of(context).primaryColor,
            child: const Text('Next'),
          ),
          // child: GestureDetector(
          //   onTap: () => Utils.navPush(context, const TutorialScreen()),
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).primaryColor,
          //     ),
          //     child: const Text(
          //       'Next',
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: Sizes.size16,
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
