import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/constants/gaps.dart';
import 'package:tiktok_clone/common/constants/sizes.dart';
import 'package:tiktok_clone/common/widgets/cst_text_field.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class UserProfileBody extends ConsumerStatefulWidget {
  final String bio;
  final String link;

  const UserProfileBody({
    super.key,
    required this.bio,
    required this.link,
  });

  @override
  ConsumerState<UserProfileBody> createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends ConsumerState<UserProfileBody> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  bool _isBioEdit = false;
  bool _isLinkEdit = false;

  String _bio = '';
  String _link = '';

  void _toggleBioEdit() {
    _isBioEdit = !_isBioEdit;
    if (!_isBioEdit && widget.bio != _bio) {
      ref.read(usersProvider.notifier).updateUserBio(_bio);
    }
    setState(() {});
  }

  void _toggleLinkEdit() {
    _isLinkEdit = !_isLinkEdit;
    if (!_isLinkEdit && widget.link != _link) {
      ref.read(usersProvider.notifier).updateUserLink(_link);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _bioController.text = widget.bio;
    _linkController.text = widget.link;

    _bioController.addListener(() {
      _bio = _bioController.text;
      setState(() {});
    });
    _linkController.addListener(() {
      _link = _linkController.text;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 450,
          child: FractionallySizedBox(
            widthFactor: 0.66,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size14,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    child: const Text(
                      'Follow',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size11,
                      horizontal: Sizes.size9,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(
                        Sizes.size4,
                      ),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.youtube,
                      size: Sizes.size22,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size16,
                      vertical: Sizes.size14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.caretDown,
                      size: Sizes.size16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Gaps.v14,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size32),
          child: _isBioEdit
              ? CstTextField(
                  controller: _bioController,
                  hintText: 'Please write your intro',
                  suffix: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => _bioController.clear(),
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: Colors.grey.shade500,
                            size: Sizes.size20,
                          ),
                        ),
                        Gaps.h5,
                        GestureDetector(
                          onTap: _toggleBioEdit,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            color: Colors.grey.shade500,
                            size: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Text(
                        // 'All highlights and where to watch live matches on FIFA+',
                        widget.bio,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Gaps.h8,
                    GestureDetector(
                      onTap: _toggleBioEdit,
                      child: const FaIcon(
                        FontAwesomeIcons.pen,
                        size: Sizes.size14,
                      ),
                    ),
                  ],
                ),
        ),
        Gaps.v14,
        _isLinkEdit
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size32),
                child: CstTextField(
                  controller: _linkController,
                  hintText: 'Please write your link',
                  suffix: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => _linkController.clear(),
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: Colors.grey.shade500,
                            size: Sizes.size20,
                          ),
                        ),
                        Gaps.h5,
                        GestureDetector(
                          onTap: _toggleLinkEdit,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            color: Colors.grey.shade500,
                            size: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.link,
                    size: Sizes.size12,
                  ),
                  Text(
                    // ' https://www.fifa.com/fifaplus/en/home',
                    ' ${widget.link}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  Gaps.h8,
                  GestureDetector(
                      onTap: _toggleLinkEdit,
                      child: const FaIcon(
                        FontAwesomeIcons.pen,
                        size: Sizes.size14,
                      ))
                ],
              ),
      ],
    );
  }
}
