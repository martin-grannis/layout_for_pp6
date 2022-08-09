import 'package:flutter/material.dart';

class MyColors {
  static const myBlack = Color(0xFF000000);
  static const myRed = Color(0xFFB10F2E);
  static const myPalerRed = Color(0xFFB10F2E);
  static const myBrown = Color(0xFF570000);
  static const myWhite = Color(0xFFFDFFFF);
  static const myBlue = Color(0xFF20A4F3);
}

Color lighten(Color color, [double amount = 0.49]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

Color hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
}