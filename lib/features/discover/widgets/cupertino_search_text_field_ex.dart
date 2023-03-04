import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/utils/common_utils.dart';

class CupertinoSearchTextFieldEx extends StatelessWidget {
  final TextEditingController? textEditingController;
  final void Function(String)? onSearchChanged;
  final void Function(String)? onSearchSubmitted;

  const CupertinoSearchTextFieldEx({
    Key? key,
    this.textEditingController,
    this.onSearchChanged,
    this.onSearchSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: textEditingController,
      onChanged: onSearchChanged,
      onSubmitted: onSearchSubmitted,
      style: TextStyle(
        color: isDarkMode(context) ? Colors.white : Colors.black,
      ),
    );
  }
}
