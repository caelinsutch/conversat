import 'package:Conversat/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

class PurpleButton extends StatelessWidget {

  final VoidCallback onPressed;
  final Widget child;

  const PurpleButton({Key key, this.onPressed, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        elevation: 10,
        onPressed: onPressed,
        color: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textColor: Color.fromARGB(255, 255, 255, 255),
        padding: EdgeInsets.all(0),
        child: child);
  }
}
