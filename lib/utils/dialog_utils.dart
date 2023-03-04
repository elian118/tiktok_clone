import 'package:flutter/material.dart';

void callDialog(
  BuildContext context, {
  double? width,
  double? height,
  required Widget child,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        clipBehavior: Clip.hardEdge,
        content: Builder(
          builder: (context) => SizedBox(
            height: height,
            width: width,
            child: child,
          ),
        ),
      ),
    );
