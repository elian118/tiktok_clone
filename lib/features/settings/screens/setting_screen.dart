import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/settings/widgets/about_list_tile_ex.dart';
import 'package:tiktok_clone/features/settings/widgets/date_time_picker_ex.dart';
import 'package:tiktok_clone/utils/utils.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notification = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notification = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Switch.adaptive() = CupertinoSwitch(...)
          // Switch.adaptive(
          //   value: _notification,
          //   onChanged: _onNotificationsChanged,
          // ),
          // Switch(
          //   value: _notification,
          //   onChanged: _onNotificationsChanged,
          // ),
          // Switch -> SwitchListTile(title, ...) -> SwitchListTile(title, ...).adaptive -> 쿠퍼티노 스타일 스위치리스트타일
          SwitchListTile.adaptive(
            value: _notification,
            onChanged: _onNotificationsChanged,
            title: const Text('Enable notifications'),
            subtitle: const Text('Enable notifications'),
          ),
          // Checkbox(
          //   value: _notification,
          //   onChanged: _onNotificationsChanged,
          // ),
          // Checkbox -> CheckboxListTile(title, ...)
          CheckboxListTile(
            activeColor: Theme.of(context).primaryColor,
            // checkColor: Theme.of(context).primaryColor,
            value: _notification,
            onChanged: _onNotificationsChanged,
            title: const Text('Notification'),
          ),
          ListTile(
            title: const Text('Log out (iOS)'),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text("Please don't go"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Utils.navPop(context),
                      child: const Text('No'),
                    ),
                    CupertinoDialogAction(
                      onPressed: () => Utils.navPop(context),
                      isDestructiveAction: true, // 폰트에 빨간색 입혀짐
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Log out (Android)'),
            textColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  // icon: const FaIcon(FontAwesomeIcons.skull),
                  title: const Text('Are you sure?'),
                  content: const Text("Please don't go"),
                  actions: [
                    IconButton(
                      onPressed: () => Utils.navPop(context),
                      icon: const FaIcon(FontAwesomeIcons.car),
                    ),
                    TextButton(
                      onPressed: () => Utils.navPop(context),
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Log out (iOS / Bottom)'),
            textColor: Colors.red,
            onTap: () {
              // 쿠퍼티노 모달 vs 쿠퍼티노 다이얼로그
              //  공통: 액션버튼 텍스트가 길어지면 좌우로 꽉참
              //  차이
              //    1. 쿠퍼티노 모달은 다른 영역을 눌렀을 때 창이 알아서 닫힘
              //    2. 액션버튼 텍스트가 길어져 좌우로 꽉 찬 경우 -> 모달은 아래, 다이얼로그는 위로 배치됨
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: const Text('Are you sure?'),
                  message: const Text('Please dooooooon gooooo'),
                  actions: [
                    CupertinoActionSheetAction(
                      isDefaultAction: true, // 기본 선택 효과 -> 폰트 굵게
                      onPressed: () => Utils.navPop(context),
                      child: const Text('Not log out'),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () => Utils.navPop(context),
                      isDestructiveAction: true, // 폰트에 빨간색 입혀짐
                      child: const Text('Yes, Please.'),
                    ),
                  ],
                ),
              );
            },
          ),
          const DateTimePickerEx(),
          const AboutListTileEx(),
          // const IndicatorEx(),
          // const ListWheelScrollViewEx(),
        ],
      ),
    );
  }
}
