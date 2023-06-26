import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class CustomSnackBars {
  static successSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
    ));
  }

  static failureSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text), backgroundColor: Colors.red));
  }

  static somethingWentWrongSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(S.of(context).somethingwentwrong),
        backgroundColor: Colors.red));
  }
}
