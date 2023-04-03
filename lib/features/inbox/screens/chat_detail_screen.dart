import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/avatar_form.dart';
import 'package:tiktok_clone/features/inbox/view_models/messages_vm.dart';
import 'package:tiktok_clone/features/inbox/widgets/frequently_used_texts.dart';
import 'package:tiktok_clone/utils/common_utils.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = 'chatDetail';
  static const String routeURL = ':chatId'; // nested route -> 맨 앞에 '/'가 없어야 한다.

  final String chatId;
  const ChatDetailScreen({
    Key? key,
    required this.chatId,
  }) : super(key: key);

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _editingController =
      TextEditingController(text: '');

  late bool _isThereMessage = _editingController.text.isNotEmpty;

  void _onMessageChanged(String text) {
    _isThereMessage = text.isNotEmpty;
    setState(() {});
  }

  void _onSendPress(String text) {
    if (!_isThereMessage) return;
    ref.read(messagesProvider.notifier).sendMessage(text);
    print('send a message: $text');
    _editingController.text = '';
    // setState(() {}); // ConsumerStatefulWidget 은 VM 에서 setState 실행하므로 불필요
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messagesProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDarkMode(context) ? Colors.grey.shade800 : Colors.grey.shade100,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: const AvatarForm(),
          title: Text(
            'xxxxmmm967 (${widget.chatId})',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDarkMode(context) ? Colors.white : Colors.black,
            ),
          ),
          subtitle: const Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: isDarkMode(context) ? Colors.white : Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: isDarkMode(context) ? Colors.white : Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => focusout(context),
        child: Container(
          color:
              isDarkMode(context) ? Colors.grey.shade700 : Colors.grey.shade100,
          child: Stack(
            children: [
              ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size20,
                  horizontal: Sizes.size14,
                ),
                itemBuilder: (context, index) {
                  final isMine = index % 2 == 0; // 홀짝 구분
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: isMine
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(Sizes.size10),
                        decoration: BoxDecoration(
                          color: isMine
                              ? Colors.blue
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(Sizes.size20),
                            topRight: const Radius.circular(Sizes.size20),
                            bottomLeft: Radius.circular(
                              isMine ? Sizes.size20 : Sizes.size5,
                            ),
                            bottomRight: Radius.circular(
                              isMine ? Sizes.size5 : Sizes.size20,
                            ),
                          ),
                        ),
                        child: const Text(
                          'this is a message',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Gaps.h10,
                itemCount: 10,
              ),
              const Positioned(
                left: Sizes.size12,
                bottom: 134,
                child: FrequentlyUsedTexts(),
              ),
              Positioned(
                bottom: 0,
                width: getWinWidth(context),
                child: BottomAppBar(
                  height: 120,
                  elevation: 0,
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size10, horizontal: Sizes.size14),
                    child: Row(
                      children: [
                        TextField(
                          controller: _editingController,
                          onChanged: _onMessageChanged,
                          onSubmitted: isLoading ? null : _onSendPress,
                          decoration: InputDecoration(
                            hintText: 'Send a message...',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Sizes.size20),
                              borderSide: BorderSide.none,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width - 134,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            suffixIcon: Container(
                              width: Sizes.size20,
                              alignment: Alignment.center,
                              child: const FaIcon(
                                FontAwesomeIcons.faceSmile,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Gaps.h10,
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: _isThereMessage
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade200,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(Sizes.size10),
                          ),
                          onPressed: () => isLoading
                              ? null
                              : _onSendPress(_editingController.text),
                          child: FaIcon(
                            isLoading
                                ? FontAwesomeIcons.hourglass
                                : FontAwesomeIcons.solidPaperPlane,
                            color: Colors.white,
                            size: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
