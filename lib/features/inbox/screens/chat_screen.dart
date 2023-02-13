import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/screens/chat_detail_screen.dart';
import 'package:tiktok_clone/utils/utils.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  final Duration _duration = const Duration(milliseconds: 500);

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        _items.length,
        duration: _duration,
      );
      _items.add(_items.length); // 배열 뒤에 추가
    }
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        // removeItem() -> 두 번째 매개변수 animation 자동 입력됨
        // 아이템 제거 애니메이션
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: Container(
            color: Colors.red,
            child: _makeTile(index),
          ),
        ),
        duration: _duration,
      );
      _items.removeAt(index);
    }
  }

  ListTile _makeTile(int index) {
    return ListTile(
      onLongPress: () => _deleteItem(index),
      onTap: () => Utils.navPush(context, const ChatDetailScreen()),
      key: UniqueKey(), // 유니크 키 적용 => 정확한 요소별 매핑 완료 -> 화면에 보인다.
      leading: const CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/11626327?v=4'),
        child: Text('Hamdamboy'),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'xxxxmmm967 $index',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            '2:16 PM',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size12,
            ),
          ),
        ],
      ),
      subtitle: const Text('Say hi to AntonioBM'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direct messages'),
        elevation: 1,
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.plus),
            onPressed: _addItem,
          )
        ],
      ),
      body: AnimatedList(
        key: _key, // AnimatedList 적용 시 참조키 지정 필요
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        itemBuilder: (
          BuildContext context,
          int index,
          Animation<double> animation, // 기본 애니메이션 설정 주입 및 자식에서 재활용
        ) {
          return FadeTransition(
            opacity: animation, // 희미하게 등장하며
            child: ScaleTransition(
              scale: animation, // 스케일 커지며
              child: SizeTransition(
                sizeFactor: animation, // 축 사이즈 증가
                child: _makeTile(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
