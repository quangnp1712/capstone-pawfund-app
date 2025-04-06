import 'package:flutter/material.dart';

typedef CloseDialog = void Function();
typedef ShowDialog = void Function();

CloseDialog closeLoadingDialog({required BuildContext context}) {
  return () {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  };
}

ShowDialog showLoadingDialog({required BuildContext context}) {
  return () => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => const Center(
            child: CircularProgressIndicator(
              color: Colors.black54,
            ),
          ));
}
