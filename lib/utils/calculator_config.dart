import 'package:flutter/material.dart';

class CalculatorConfig {
  CalculatorConfig({
    required this.calculatorSide,
    this.animationCurve = Curves.easeIn,
    this.keyBorderRadius = 15,
    this.keysHaveShadow = true,
    this.baseColor = Colors.blueGrey,
  });

  final double keyBorderRadius;
  final bool keysHaveShadow;
  final MaterialColor baseColor;

  final Color keysShadowColor = Colors.blueGrey.shade900.withOpacity(0.3);

  double get keysGap => calculatorSide * 0.04;
  final Curve animationCurve;

  final int keysPerRow = 4;

  double get fontSize => keySideMin * 0.6;

  final double calculatorSide;

  double get keySideMin =>
      (calculatorSide - (keysGap * (keysPerRow - 1))) / keysPerRow;

  Size get calculatorSize => Size(calculatorSide, calculatorSide);
}
