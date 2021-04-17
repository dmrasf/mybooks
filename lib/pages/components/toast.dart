import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { HINT, ERROR }

void showToast(BuildContext context, String msg, {ToastType? type}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: type == null
        ? Theme.of(context).hintColor
        : type == ToastType.HINT
            ? Theme.of(context).hintColor
            : Theme.of(context).errorColor,
    textColor: Colors.black87,
    fontSize: 13,
  );
}
