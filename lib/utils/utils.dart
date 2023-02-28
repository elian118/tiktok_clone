import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 포커스 아웃 -> 자식 위젯의 GestureDetector 영역(여기서는 TextField)을 제외한 부모 위젯에서만 발동
void focusout(BuildContext context) {
  FocusScope.of(context).unfocus();
}

// 스크린 너비값 가져오기
double getWinWidth(BuildContext context) => MediaQuery.of(context).size.width;

// 스크린 높이값 가져오기
double getWinHeight(BuildContext context) => MediaQuery.of(context).size.height;

// 웹화면인가?
bool isWebScreen(BuildContext context) => kIsWeb;

// 다크모드인가?
bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

// 한국어인가?
bool isKorean(BuildContext context) =>
    Localizations.localeOf(context).toString() == 'ko';

/*
  앱과 함께 웹을 동시 지원하는 Navigator2 등장 이후 GoRouter()를 사용하게 되면서부터
   아래 정의된 routePush(), navPagePush() 방식들은 전부 구식이 됐다.

  실제로, 플러터 공식 홈에서는 아래 routePush() 방식을 지양하라고 공지하고 있다.

  플러터에 따르면, routePush() -> pushNamed(routeName, arguments: args)는
   url 을 직접 입력해 원하는 페이지로 이동이 가능한 반면에,
   웹 브라우저의 뒤로가기 기능을 지원하지 않는다고 한다. -> 버튼 눌러도 동작 안 함

  반면에, navPagePush() 방식은 웹 브라우저의 뒤로가기 기능을 지원하지만,
   -> 페이지 이동 후 url 변경이 되질 않고 그대로이다.
   -> 즉, url 을 직접 입력해 원하는 페이지로 이동할 수 없는 문제가 있다.

   GoRouter 는 이러한 문제를 해결하기 위해 등장했으며,
   일반적인 웹 개발의 라우팅 방식처럼 파라미터까지 문자열 안에 중첩적으로 입력할 수 있다.

   /user/video/:username/:id
*/

// 아레 코드는 앱 전용 Navigator1 유틸
// 모든 네비게이터는 스택(Stack) 구조이며, 밑에서부터 위로 겹쳐 쌓는 형태로 렌더링 -> Flutter Outline 확인
// 화면에 넘긴 파라미터 가져오기
Object? getParams(BuildContext context) =>
    ModalRoute.of(context)!.settings.arguments;

// 화면 이동(특정된 이름이 붙은 화면으로 라우트하는 방식)
void routePush(
  BuildContext context,
  String routeName, {
  Object? args,
}) async {
  final result =
      await Navigator.of(context).pushNamed(routeName, arguments: args);
  if (kDebugMode) print(result);
}

// 화면 이동(실제로는 화면 추가)
void navPush(
  BuildContext context,
  Widget widget, [
  bool? isFullScreenDialog,
]) async {
  // 화면(PageRoute 대상)을 추가하면, 추가된 화면이 바로 위에 쌓여 마치 스크린을 이동한 것처럼 보이게 됨.
  final result = await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
      fullscreenDialog: isFullScreenDialog ?? false, // 꽉찬 다이얼로그로 표시 여부 설정
    ),
  );
  if (kDebugMode) {
    print(result);
  }
}

// 화면 이동(PageRouteBuilder 방식) => 애니메이션 커스더마이징 가능
void navPagePush(
  BuildContext context,
  Widget widget, [
  bool? isFullScreenDialog,
]) async {
  // 화면(PageRoute 대상)을 추가하면, 추가된 화면이 바로 위에 쌓여 마치 스크린을 이동한 것처럼 보이게 됨.
  final result = await Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration:
          const Duration(milliseconds: 500), // 뒤로가기 작동 애니메이션 시간
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // 위치 이동 애니메이션
        final offsetAnimation = Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation);
        // 투명도 애니메이션
        final opacityAnimation = Tween(
          begin: 0.5,
          end: 1.0,
        ).animate(animation);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: opacityAnimation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      fullscreenDialog: isFullScreenDialog ?? false, // 꽉찬 다이얼로그로 표시 여부 설정
    ),
  );
  if (kDebugMode) {
    print(result);
  }
}

// 조건부 화면 이동 -> 세 번째 인자(조건 콜백)을 생략하면 navPush 메서드와 같다.
void navPushAndRemoveUntil(
  BuildContext context,
  Widget widget, [
  // 콜백이 false 반환 시 네비게이터 아래 쌓인 라우트 스택 모두 제거(초기화) -> 뒤로가기 할 화면 제거됨
  bool Function(Route<dynamic>)? predicate,
]) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => widget),
    // 기본: predicate 생략 시 네비게이터 라우트 스텍 유지 -> 뒤로가기 할 화면 유지
    predicate ?? (route) => true,
  );
}

// 뒤로 가기(실제로는 맨 위에 놓인 화면 제거)
void navPop(BuildContext context, [dynamic result]) {
  Navigator.of(context).pop(result);
}
