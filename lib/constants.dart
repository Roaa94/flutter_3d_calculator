import 'package:flutter/material.dart';

class Constants {
  static const double keyBorderRadius = 15;
  static const Size squareKeySize = Size(100, 100);
  static const Size recHKeySize = Size(100 * 2, 100);
  static const Size recVKeySize = Size(100, 100 * 2);
  static const double keysGap = 20;
  static const Curve curve = Curves.easeOut;

  static const double squareKeySide = 100;
  static const int keysPerRow = 4;
  static const int keysPerCol = 4;
  static const double calculatorWidth =
      keysPerRow * squareKeySide + (keysGap * (keysPerRow - 1));
  static const double calculatorHeight =
      keysPerCol * squareKeySide + (keysGap * (keysPerCol - 1));
  static const Size calculatorSize = Size(calculatorWidth, calculatorHeight);
  static const double keyTextFontSize = squareKeySide * 0.6;
}
