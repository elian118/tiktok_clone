import 'package:flutter/material.dart';

class AboutListTileEx extends StatelessWidget {
  const AboutListTileEx({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // return const ListTile(
    //   onTap: () => showAboutDialog(
    //     context: context,
    //     applicationVersion: "v 1.0",
    //     applicationLegalese:
    //         "Copyright(c) All rights reserved. Please don't copy me.",
    //   ),
    //   title: const Text(
    //     'About',
    //     style: TextStyle(
    //       fontWeight: FontWeight.w600,
    //     ),
    //   ),
    //   subtitle: const Text("About this app.."),
    // );
    // 위 코드를 간소화한 위젯
    return const AboutListTile(
      applicationVersion: "v 1.0",
      applicationLegalese: "Copyright(c) All rights reserved.",
    );
  }
}
