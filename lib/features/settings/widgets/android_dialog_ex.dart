import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/utils/route_utils.dart';

class AndroidDialogEx extends StatelessWidget {
  const AndroidDialogEx({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
                onPressed: () => navPop(context),
                icon: const FaIcon(FontAwesomeIcons.car),
              ),
              TextButton(
                onPressed: () => navPop(context),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
    );
  }
}
