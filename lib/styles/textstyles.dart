import 'dart:ui';

import 'package:Conversat/styles/appcolors.dart';
import 'package:flutter/material.dart';

class TextStyles {

  static TextStyle get h1Primary {
    return TextStyle(
      color: AppColors.primary,
      fontFamily: mainFamily,
      fontWeight: FontWeight.w700,
      fontSize: 42,
    );
  }

  static TextStyle get h1Grey {
    return TextStyle(
      color: AppColors.grey5,
      fontFamily: mainFamily,
      fontWeight: FontWeight.w700,
      fontSize: 42,
    );
  }

  static TextStyle get h2Primary {
    return TextStyle(
      color: AppColors.primary,
      fontFamily: mainFamily,
      fontWeight: FontWeight.w700,
      fontSize: 24,
    );
  }

  static TextStyle get h2White {
    return TextStyle(
      color: Colors.white,
      fontFamily: mainFamily,
      fontWeight: FontWeight.w700,
      fontSize: 24
    );
  }

  static TextStyle get h3White {
    return TextStyle(
        color: Colors.white,
        fontFamily: mainFamily,
        fontWeight: FontWeight.w700,
        fontSize: 18
    );
  }

  static const String mainFamily = "Visby Round CF";
  static const FontWeight mainWeight = FontWeight.w700;
  static const FontStyle mainStyle = FontStyle.normal;
}
