import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/settings/widgets/about_list_tile_ex.dart';
import 'package:tiktok_clone/features/settings/widgets/android_dialog_ex.dart';
import 'package:tiktok_clone/features/settings/widgets/cupertino_dialog_ex.dart';
import 'package:tiktok_clone/features/settings/widgets/cupertino_modal_ex.dart';
import 'package:tiktok_clone/features/settings/widgets/date_time_picker_ex.dart';

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
            title: const Text('Marketing emails'),
            subtitle: const Text("We won't spam you."),
          ),
          const DateTimePickerEx(),
          const CupertinoDialogEx(),
          const AndroidDialogEx(),
          const CupertinoModalEx(),
          const AboutListTileEx(),
          // const IndicatorEx(),
          // const ListWheelScrollViewEx(),
        ],
      ),
    );
  }
}