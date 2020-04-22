import 'dart:math';

import 'package:Conversat/styles/appcolors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlutterActions {
  static purpleSnackBarTop(BuildContext context, String text) {
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: AppColors.primary,
      boxShadows: [BoxShadow(
        color: AppColors.primary.withAlpha(160),
        blurRadius: 10,
        offset: Offset.fromDirection(pi/2, 10)
      )],
      borderRadius: 20,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
      message: text
    )..show(context);
  }
}