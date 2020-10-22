import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertModal(
    {BuildContext context,
    String title,
    String content,
    String okBtnText}) async {
  await showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(okBtnText),
          ),
        ],
      );
    },
  );
}
