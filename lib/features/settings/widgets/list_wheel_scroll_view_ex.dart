import 'package:flutter/material.dart';

class ListWheelScrollViewEx extends StatelessWidget {
  const ListWheelScrollViewEx({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      diameterRatio: 1.5, // 바퀴 반지를 설정
      offAxisFraction: -0.5, // 바퀴(x)축 회전 설정
      itemExtent: 200, // 아이템 높이
      // useMagnifier: true, // 돋보기 사용
      // magnification: 1.5,
      children: [
        for (var x in [1, 2, 3, 1, 4, 15, 1, 3, 4, 5, 3])
          FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              color: Colors.teal,
              alignment: Alignment.center,
              child: Text(
                'Pick me $x',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 39,
                ),
              ),
            ),
          )
      ],
    );
  }
}
