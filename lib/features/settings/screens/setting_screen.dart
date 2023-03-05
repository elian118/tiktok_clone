import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/constants/enums/breakpoints.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config_change_notifier.dart';
import 'package:tiktok_clone/common/widgets/web_container.dart';
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
    // 번역 강제 오버라이드(현재 위젯만 해당)
    return Localizations.override(
      context: context,
      // locale: const Locale('es'),
      locale: const Locale('ko'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListView(
          children: [
            WebContainer(
              maxWidth: Breakpoint.sm,
              child: AnimatedBuilder(
                animation: videoConfig,
                builder: (BuildContext context, Widget? child) =>
                    SwitchListTile.adaptive(
                        value: videoConfig.autoMute,
                        onChanged: (value) => videoConfig.toggleAutoMute(),
                        title: const Text('Auto Mute'),
                        subtitle:
                            const Text('Video will be muted by default,')),
              ),
            ),
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
            WebContainer(
              maxWidth: Breakpoint.sm,
              child: SwitchListTile.adaptive(
                value: _notification,
                onChanged: _onNotificationsChanged,
                title: const Text('Enable notifications'),
                subtitle: const Text('Enable notifications'),
              ),
            ),
            // Checkbox(
            //   value: _notification,
            //   onChanged: _onNotificationsChanged,
            // ),
            // Checkbox -> CheckboxListTile(title, ...)
            WebContainer(
              maxWidth: Breakpoint.sm,
              child: CheckboxListTile(
                activeColor: Theme.of(context).primaryColor,
                // checkColor: Theme.of(context).primaryColor,
                value: _notification,
                onChanged: _onNotificationsChanged,
                title: const Text('Marketing emails'),
                subtitle: const Text("We won't spam you."),
              ),
            ),
            const WebContainer(
                maxWidth: Breakpoint.sm, child: DateTimePickerEx()),
            const WebContainer(
                maxWidth: Breakpoint.sm, child: CupertinoDialogEx()),
            const WebContainer(
                maxWidth: Breakpoint.sm, child: AndroidDialogEx()),
            const WebContainer(
                maxWidth: Breakpoint.sm, child: CupertinoModalEx()),
            const WebContainer(
                maxWidth: Breakpoint.sm, child: AboutListTileEx()),
            // const IndicatorEx(),
            // const ListWheelScrollViewEx(),
          ],
        ),
      ),
    );
  }
}
