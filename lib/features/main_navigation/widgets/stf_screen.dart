import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

// MainNavigationScreen > 네비게이션 선택 시, 바디에 빌드될 위젯 샘플
// > body: Stack(children: [ ...Offstage( child: StfScreen() ] )
class StfScreen extends StatefulWidget {
  const StfScreen({Key? key}) : super(key: key);

  @override
  State<StfScreen> createState() => _StfScreenState();
}

class _StfScreenState extends State<StfScreen> {
  int _clicks = 0;

  void _increase() {
    setState(() {
      _clicks = _clicks + 1;
    });
  }

  @override
  void dispose() {
    print(_clicks);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_clicks',
            style: const TextStyle(fontSize: Sizes.size48),
          ),
          TextButton(
            onPressed: _increase,
            child: const Text('+'),
          ),
        ],
      ),
    );
  }
}
