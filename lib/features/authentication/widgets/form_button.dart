import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  // 부모 위젯 email_screen.dart 참고
  // 참고: 위젯 추출 v.1로 코드 분리 시, 아래와 같이 독특한 생성자 패턴이 자동 생성된다.
  /*const FormButton({
    super.key,
    required String username, // required String _username, -> 이렇게 생성 불가하기 때문
  }) : _username = username;

  final String _username;*/

  // 위젯 추출 v.2처럼 조건식으로 변수 인라인화 시, 위 코드를 아래와 같이 바꿀 수 있다.
  const FormButton({
    super.key,
    required this.disabled,
    this.text = '', // optional field with default value
  });

  final bool disabled; // 런타임 상수(final)는 빌드타임 상수(const) 보다 늦게 선언돼도 상관 없다.
  final String text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      // Container -> AnimatedContainer : 스타일 적용시간만 지정하면 애니메이션 효과 자동 적용되는 컨테이너
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
        duration: const Duration(milliseconds: 500), // 컨테이너 스타일 전환시간
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size5),
          color: disabled // _username.isEmpty
              ? Theme.of(context).disabledColor
              : Theme.of(context).primaryColor,
        ),
        // 텍스트 전환 효과를 AnimatedContainer 주기에 맞춤
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 500), // 텍스트 스타일 전환시간
          style: TextStyle(
            color: disabled // _username.isEmpty
                ? Theme.of(context).disabledColor
                : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          child: Text(
            text.isNotEmpty ? text : 'Next',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
