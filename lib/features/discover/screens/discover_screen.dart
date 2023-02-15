import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/enums/breakpoints.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/rawData/discovers.dart';
import 'package:tiktok_clone/common/constants/rawData/foreground_image.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/utils/utils.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController =
      TextEditingController(text: 'Initial Text');

  late bool _isThereSearchValue = _textEditingController.text.isNotEmpty;

  void _onSearchChanged(String value) {
    print(value);
    setState(() {
      _isThereSearchValue = value.isNotEmpty;
    });
  }

  void _onSearchSubmitted(String value) {
    if (!_isThereSearchValue) return;
    print('Submitted $value');
  }

  void _onCloseIcon() {
    setState(() {
      _textEditingController.text = '';
      _isThereSearchValue = false;
    });
  }

  void _moveBack() {
    print('The Back button has been pressed.');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = Utils.getWinWidth(context);
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1, // 앱바와 바디 사이 구분선 효과
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: _moveBack,
                  child: const FaIcon(FontAwesomeIcons.chevronLeft)),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.size18),
                  height: Sizes.size44,
                  child: TextField(
                    controller: _textEditingController,
                    onChanged: _onSearchChanged,
                    onSubmitted: _onSearchSubmitted,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sizes.size5),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size12),
                      prefixIcon: Container(
                        width: Sizes.size20,
                        alignment: Alignment.center,
                        child: const FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Colors.black,
                          size: Sizes.size18,
                        ),
                      ),
                      suffixIcon: Container(
                        width: Sizes.size20,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(
                          left: Sizes.size10,
                          right: Sizes.size8,
                        ),
                        child: AnimatedOpacity(
                          opacity: _isThereSearchValue ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: GestureDetector(
                            onTap: _onCloseIcon,
                            child: FaIcon(
                              FontAwesomeIcons.solidCircleXmark,
                              color: Colors.grey.shade600,
                              size: Sizes.size18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const FaIcon(FontAwesomeIcons.sliders),
            ],
          ),
          // 쿠퍼티노텍스트필드
          // title: CupertinoSearchTextField(
          //   controller: _textEditingController,
          //   onChanged: _onSearchChanged,
          //   onSubmitted: _onSearchSubmitted,
          // ),
          // PreferredSizeWidget bottom -> 자식의 크기를 제한하지 않는다. TabBar 가 대표적
          bottom: TabBar(
            onTap: (value) => Utils.focusout(context),
            splashFactory: NoSplash.splashFactory, // 클릭 시 기본 번짐 효과 제거
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
            tabs: [
              for (var tab in tabs) Tab(text: tab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              // 스크롤 동안 키보드 감추기
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: 20,
              padding: const EdgeInsets.all(Sizes.size6),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width > Breakpoint.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 20, // 그리드 비율
              ),
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/windmill-7367963.jpg',
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
                          foregroundImage: NetworkImage(foregroundImage),
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
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
