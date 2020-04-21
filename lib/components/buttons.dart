import 'package:Conversat/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

class Buttons {
  @widget
  static Widget button(BuildContext context, Function onPressed) {
    return FlatButton(
        onPressed: onPressed,
        color: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textColor: Color.fromARGB(255, 255, 255, 255),
        padding: EdgeInsets.all(0),
        child: Text(
            "Login with Google",
            textAlign: TextAlign.center,
            style: TextStyles.h2White,
        )
    );
  }
}

