import 'package:flutter/material.dart';

class CstTextFormField extends StatelessWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  const CstTextFormField({
    Key? key,
    this.hintText,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).disabledColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).focusColor,
          ),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
