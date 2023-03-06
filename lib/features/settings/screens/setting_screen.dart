import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/common/constants/enums/breakpoints.dart';
import 'package:tiktok_clone/common/widgets/web_container.dart';
import 'package:tiktok_clone/features/settings/widgets/about_list_tile_ex.dart';
import 'package:tiktok_clone/features/settings/widgets/android_dialog_ex.dart';
import 'package:tiktok_clone/features/settings/widgets/cupertino_dialog_ex.dart';
import 'package:tiktok_clone/features/settings/widgets/cupertino_modal_ex.dart';
import 'package:tiktok_clone/features/settings/widgets/date_time_picker_ex.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  // bool _notification = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              child: SwitchListTile.adaptive(
                  value: ref.watch(playbackConfigProvider).darkMode,
                  onChanged: (value) => ref
                      .read(playbackConfigProvider.notifier)
                      .setDarkMode(value),
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Light mode is applied by default.')),
            ),
            WebContainer(
              maxWidth: Breakpoint.sm,
              child: SwitchListTile.adaptive(
                  value: ref.watch(playbackConfigProvider).muted,
                  onChanged: (value) => ref
                      .read(playbackConfigProvider.notifier)
                      .setMuted(value), // onChange -> 뷰에서 바뀐 값을 value 로 전달
                  // context.read<PlaybackConfigViewModel>().setMuted(value),
                  title: const Text('Auto Mute'),
                  subtitle: const Text('Video will be muted by default.')),
            ),
            WebContainer(
              maxWidth: Breakpoint.sm,
              child: SwitchListTile.adaptive(
                  value: ref.watch(playbackConfigProvider).autoplay,
                  onChanged: (value) => ref
                      .read(playbackConfigProvider.notifier)
                      .setAutoplay(value),
                  title: const Text('Auto Play'),
                  subtitle:
                      const Text('Video will be start playing automatically.')),
            ),
            WebContainer(
              maxWidth: Breakpoint.sm,
              child: SwitchListTile.adaptive(
                value: false,
                onChanged: (value) {},
                title: const Text('Enable notifications'),
                subtitle: const Text('Enable notifications'),
              ),
            ),
            WebContainer(
              maxWidth: Breakpoint.sm,
              child: CheckboxListTile(
                activeColor: Theme.of(context).primaryColor,
                // checkColor: Theme.of(context).primaryColor,
                value: false,
                onChanged: (value) {},
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
