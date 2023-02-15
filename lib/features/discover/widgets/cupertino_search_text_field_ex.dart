import 'package:flutter/cupertino.dart';

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
    );
  }
}
