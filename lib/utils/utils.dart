import 'package:flutter/material.dart';

class Utils {
  Utils._();

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showSnackbar(String? text) {
    if (text == null || text.isEmpty) return;

    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );

    messengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
