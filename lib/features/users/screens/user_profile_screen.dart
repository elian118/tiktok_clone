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
          // title: const Text('Hello'),
          floating: true, // 유동화: 스크롤 아래로 내리다 위로 다시 스크롤 하면 appBar 뜨도록 허용
          stretch: true, // 잡아 끌어 늘리기 허용
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
      ],
    );
  }
}
