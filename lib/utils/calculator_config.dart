import 'package:flutter/material.dart';

class CalculatorConfig {
  CalculatorConfig({
    this.keySideMin = 100,
    this.keysGap = 20,
    this.animationCurve = Curves.easeIn,
    this.keyBorderRadius = 15,
    this.keysHaveShadow = true,
    this.baseColor = Colors.blueGrey,
  });

  final double keySideMin;
  final double keyBorderRadius;
  final bool keysHaveShadow;
  final MaterialColor baseColor;

  final Color keysShadowColor = Colors.blueGrey.shade900.withOpacity(0.3);

  final double keysGap;
  final Curve animationCurve;

  final int keysPerRow = 4;
  final int keysPerCol = 4;

  double get fontSize => keySideMin * 0.6;

  double get calculatorWidth =>
      keysPerRow * keySideMin + (keysGap * (keysPerRow - 1));

  double get calculatorHeight =>
      keysPerCol * keySideMin + (keysGap * (keysPerCol - 1));

  Size get calculatorSize => Size(calculatorWidth, calculatorHeight);
}
