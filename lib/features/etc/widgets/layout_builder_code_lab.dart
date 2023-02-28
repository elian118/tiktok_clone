// 반응형 로직 확인을 위한 예시 위젯
import 'package:flutter/material.dart';

class LayoutBuilderCodeLab extends StatelessWidget {
  const LayoutBuilderCodeLab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width / 2,
        // LayoutBuilder -> 자식 위젯의 최대 크기 정보를 알 수 있다.
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: Colors.teal,
            child: Center(
              child: Text(
                '${constraints.maxWidth} / ${size.width}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 98,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
