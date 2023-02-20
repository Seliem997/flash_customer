import 'package:flutter/material.dart';

Future navigateTo(context, Widget widget) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ));
}

navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => widget,
    ),
    (Route<dynamic> route) => false,
  );
}
