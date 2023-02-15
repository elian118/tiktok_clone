import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/utils/utils.dart';

class CupertinoDialogEx extends StatelessWidget {
  const CupertinoDialogEx({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
