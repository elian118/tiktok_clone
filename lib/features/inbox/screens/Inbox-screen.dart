import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/constants/enums/breakpoints.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/screens/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/screens/chat_screen.dart';
import 'package:tiktok_clone/utils/common_utils.dart';
import 'package:tiktok_clone/utils/dialog_utils.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: isWebScreen(context) ? 0 : 1,
        title: const Text('Inbox'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.paperPlane),
            onPressed: () => context.goNamed(ChatScreen.routeName),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => isWebScreen(context)
                ? callDialog(
                    context,
                    width: Breakpoint.sm,
                    child: const ActivityScreen(),
                  )
                : context.pushNamed(ActivityScreen.routeName),
            title: const Text(
              'Activity',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
          Container(
            height: Sizes.size1,
            color: Colors.grey.shade200,
          ),
          ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'New followers',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            subtitle: const Text(
              'Messages from followers will appear here',
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
