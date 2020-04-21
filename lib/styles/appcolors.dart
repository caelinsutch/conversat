import 'dart:ui';

class AppColors {

  static Color colorFromHex(String hexColor) {
    Color returnColor;
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      returnColor =  Color(int.parse("0x$hexColor"));
    }

    return returnColor;
  }

  static Color primary = Color.fromARGB(255, 202, 23, 235);
  static Color grey1 = colorFromHex('#F1F1F2');
  static Color grey2 = colorFromHex('#E6E7E8');
  static Color grey3 = colorFromHex('#B7B7B7');
  static Color grey4 = colorFromHex('#58595B');
  static Color grey5 = colorFromHex('#404041');
  static Color grey6 = colorFromHex('#231F20');
}