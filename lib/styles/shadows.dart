import 'package:flutter/rendering.dart';

import 'appcolors.dart';

class Shadows {
  static BoxShadow greyShadow = BoxShadow(
    color: AppColors.grey1,
    offset: Offset(0, 10),
    blurRadius: 20,
  );
  static BoxShadow secondaryShadow = BoxShadow(
    color: AppColors.primary,
    offset: Offset(0, 20),
    blurRadius: 30,
  );
}