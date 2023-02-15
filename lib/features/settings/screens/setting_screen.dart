import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/settings/widgets/date_time_picker_ex.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const DateTimePickerEx(),
      // body: const AboutListTileEx(),
      // body: const IndicatorEx(),
      // body: const ListWheelScrollViewEx(),
    );
  }
}
