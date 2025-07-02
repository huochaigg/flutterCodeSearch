import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';   

// 提示
void showToast (String text, { Color? backgroundColor }) {
  Fluttertoast.showToast(
    msg: text,  // 提示文案
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor ?? Colors.black12,    // 背景颜色
    textColor: Colors.white,
    fontSize: 16.0
  );
}

// 错误提示，红色
void showWarnToast (String text) {
  showToast(text, backgroundColor: Colors.redAccent);
}

// 成功提示
void showSuccessToast (String text) {
  showToast(text, backgroundColor: const Color(0xFF66BB6A));
}