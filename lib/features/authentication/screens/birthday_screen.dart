import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tiktok_clone/common/constants/enums/breakpoints.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/web_container.dart';
import 'package:tiktok_clone/features/authentication/view_models/sign_up_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/birthday_date_picker.dart';
import 'package:tiktok_clone/features/authentication/widgets/birthday_header.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime initDate = DateTime.now();
  late DateTime minDate = DateTime(
    initDate.year - 12,
    initDate.month,
    initDate.day,
  );

  void _onNextTap() {
    // 파이어베이스로 회원가입 요청
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "birthday": _birthdayController.value.text,
    };
    // 매개변수 없이, 지금까지 signUpForm.state 에 담긴 값 사용
    ref.read(signUpProvider.notifier).signUp(context, mounted);
  }

  void _setTextFieldDate(DateTime date) {
    // final textDate = date.toString().split(" ").first;
    // _birthdayController.value = TextEditingValue(text: textDate);
    // 날짜 포매팅
    _birthdayController.value =
        TextEditingValue(text: DateFormat('yyyy. MM. dd').format(date));
  }

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initDate);
  }

  @override
  void dispose() {
    // 다른 인스턴스가 빌드될 때 _birthdayController 제거(메모리 관리)
    _birthdayController.dispose();
    super.dispose(); // 첫 행으로 가도 상관 없지만, 로직 파악 편의 상 메모리 정리 후 맨 아래 행 위치 권장
  }

  @override
  Widget build(BuildContext context) {
    final isWebScreen = MediaQuery.of(context).size.width > Breakpoint.lg;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Sign up'),
      ),
      body: WebContainer(
        padding: const EdgeInsets.all(Sizes.size36),
        maxWidth: Breakpoint.sm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const BirthdayHeader(),
            Gaps.v28,
            TextField(
              enabled: false, // 비활성화(포커스 무시)
              // 컨트롤러
              controller: _birthdayController,
              // 포커스 상태 밑줄 색상을 바꾸려면 enabledBorder, focusedBorder 두 속성을 모두 설정해야 한다.
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).disabledColor, // 활성 상태 밑줄 색상 지정
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context)
                        .disabledColor, // 포커스 상태 => 활성 상태와 동일 색상 유지
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v28,
            GestureDetector(
              // 1) navigate1 방식 -> 이동될 화면의 뒤로가기 방지
              // onTap: () => navPushAndRemoveUntil(
              //     context, const InterestsScreen(), (route) => false),
              // 2) navigate2(goRouter) 방식 -> 이동될 화면의 뒤로가기 방지
              onTap: _onNextTap,
              child: FormButton(
                  disabled: ref.watch(signUpProvider).isLoading ||
                      ref.watch(signUpForm).isEmpty),
            ), // 위젯 추출 v.2
            Gaps.v96,
            if (isWebScreen)
              BirthdayDatePicker(
                initialDateTime: initDate,
                minimumDate: minDate,
                maximumDate: initDate,
                onDateTimeChanged: _setTextFieldDate,
              ),
          ],
        ),
      ),
      bottomNavigationBar: !isWebScreen
          ? BottomAppBar(
              height: MediaQuery.of(context).size.height * 0.3,
              child: BirthdayDatePicker(
                initialDateTime: initDate,
                minimumDate: minDate,
                maximumDate: initDate,
                onDateTimeChanged: _setTextFieldDate,
              ),
            )
          : null,
    );
  }
}
