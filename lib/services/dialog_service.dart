import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogService {
  DialogService._();

  static final DialogService _instance = DialogService._();

  factory DialogService() => _instance;

  Future<void> showMenu({
    required BuildContext context,
    required List<Widget> actions,
    bool barrierDissmissable = true,
  }) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.zero,
        child: CupertinoActionSheet(
          actions: actions,
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ),
      ),
      barrierDismissible: barrierDissmissable,
    );
  }
}
