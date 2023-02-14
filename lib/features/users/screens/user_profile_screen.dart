import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/constants/rawData/discovers.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          // title: const Text('Hello'), // FlexibleSpaceBar > background 설정 시 미사용 권장
          floating: true, // 유동화: 스크롤 내리는 도중 다시 스크롤 올리면 appBar 100% 다시 띄우도록 허용
          snap: true, // floating 애니메이션이 부드럽지 않고 스냅을 때리듯 획획 재생되도록 설정
          stretch: true, // 앱바를 본래 높이보다 일시적 잡아 끌어 늘리기 허용
          pinned: true, // SliverAppBar 사이즈가 줄어도 타이틀 위젯 남기기(고정)
          backgroundColor: Colors.teal,
          elevation: 1,
          collapsedHeight: 80, // 접혔을 때 최소 높이
          expandedHeight: 200, // 펼쳤을 때 최대 높이
          flexibleSpace: FlexibleSpaceBar(
            // SliverAppBar > stretch: true 일때, 상세 애니메이션 옵션 추가
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
            ],
            background: Image.asset(discoveredImages[0], fit: BoxFit.cover),
            title: const Text('Hello'), // 제목을 여기에 위치해 두면 애니메이션 적용됨
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              color: Colors.amber[100 * (index % 9)],
              child: Align(
                  alignment: Alignment.center, child: Text('Item $index')),
            ),
          ),
          itemExtent: 100, // 요소 높이
        ),
      ],
    );
  }
}
