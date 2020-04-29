import 'package:Conversat/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormFields {
  static TextFormField genericFormField({BuildContext context,
      Function saveFunction, Function validatorFunction, String hint,
      bool obscure = false, int minLines,
        TextInputType keyboardType = TextInputType.text,
        String initialValue = '', TextInputAction textInputAction}) {
    return TextFormField(
      obscureText: obscure,
      maxLines: null,
      minLines: minLines,
      keyboardType: keyboardType,
      validator: validatorFunction,
      onSaved: saveFunction,
      initialValue: initialValue,
      textInputAction: textInputAction,
      style: TextStyles.h3Black,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
        new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none),
      ),
    );
  }
}
