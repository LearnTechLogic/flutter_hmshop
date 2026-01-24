import 'package:flutter/material.dart';

class ToastUtils {
  static void showToast(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          width: 120,
          shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(10)
              borderRadius: BorderRadiusGeometry.circular(40)
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 5),
          content: Text(message ?? "加载中...", textAlign: TextAlign.center)
      )
    );
  }
}