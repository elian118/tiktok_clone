import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/avatar_form.dart';
import 'package:tiktok_clone/features/inbox/widgets/frequently_used_texts.dart';
import 'package:tiktok_clone/utils/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController =
      TextEditingController(text: '');

  late bool _isThereMessage = _messageController.text.isNotEmpty;

  void _onMessageChanged(String value) {
    setState(() {
      _isThereMessage = value.isNotEmpty;
    });
  }

  void _onMsgSubmit(String value) {
    if (!_isThereMessage) return;
    print('send a message: $value');
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: const AvatarForm(),
          title: const Text(
            'xxxxmmm967',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          subtitle: const Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => Utils.focusout(context),
        child: Container(
          color: Colors.grey.shade100,
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
                bottom: 104,
                child: FrequentlyUsedTexts(),
              ),
              Positioned(
                bottom: 0,
                width: MediaQuery.of(context).size.width,
                child: BottomAppBar(
                  elevation: 0,
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size10, horizontal: Sizes.size14),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            onChanged: _onMessageChanged,
                            onSubmitted: _onMsgSubmit,
                            decoration: InputDecoration(
                              hintText: 'Send a message...',
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size12),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size20),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
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
                        ),
                        Gaps.h10,
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: _isThereMessage
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade300,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(Sizes.size10),
                          ),
                          onPressed: () =>
                              _onMsgSubmit(_messageController.text),
                          child: const FaIcon(
                            FontAwesomeIcons.solidPaperPlane,
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
