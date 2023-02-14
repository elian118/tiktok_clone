import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/constants/rawData/discovers.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';

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
          // floating: true, // 유동화: 스크롤 내리는 도중 다시 스크롤 올리면 appBar 100% 다시 띄우도록 허용
          // snap: true, // floating 애니메이션이 부드럽지 않고 스냅을 때리듯 획획 재생되도록 설정
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
        SliverToBoxAdapter(
          child: Column(
            children: const [
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 20,
              )
            ],
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
        SliverPersistentHeader(
          // SliverPersistentHeader > delegate : 다른 슬리버 위젯보다 복잡
          //  SliverPersistentHeaderDelegate 상속 위젯에서 필수 추상메서드 4개를 모두 재정의해야 하기 때문
          //  참고 -> 추상메서드 4종은 예외를 발생시키도록 기본 설정돼 있으니, 반환값을 재정의 안 하면 에러만 뜬다.
          delegate: CustomDelegate(),
          pinned: true, // 슬리버 스크롤 시 앱바 아래 고정
          // SliverAppBar > pinned: true 설정이 없다면,
          //  아래 SliverPersistentHeader > floating: true 설정은 자신의 영역부터 SliverAppBar 처럼 pinned 돼 작동한다.
          // floating: true, // SliverAppBar > pinned: true 상태에서 스크롤 내리는 도중 다시 올리면 일부가 조금 보이는 형태를 취함
        ),
        SliverGrid(
          // SliverFixedExtentList > delegate 와 실행방식 동일
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              color: Colors.amber[100 * (index % 9)],
              child: Align(
                  alignment: Alignment.center, child: Text('Item $index')),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100, // 자식별 최대 너비값
            mainAxisSpacing: Sizes.size20,
            crossAxisSpacing: Sizes.size20,
            childAspectRatio: 1, // 자식 표시비율 -> Ex. 16:9 비율은 16 / 9
          ),
        ),
      ],
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.indigo,
      child: const FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text(
            'Title!!!!!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // 최대 확장 높이
  @override
  double get maxExtent => 150;

  // 최소 축소 높이
  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
    // throw UnimplementedError();
  }
}
