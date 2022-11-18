import 'package:flutter/material.dart';

class CalculatorConfig {
  CalculatorConfig({
    required this.calculatorSide,
    this.animationCurve = Curves.easeIn,
    this.borderRadius = 15,
    this.keysHaveShadow = true,
    this.baseColor = Colors.blueGrey,
    this.startAt3D = true,
  });

  final double borderRadius;
  final bool keysHaveShadow;
  final MaterialColor baseColor;
  final bool startAt3D;

  final Color keysShadowColor = Colors.blueGrey.shade900;

  double get keysGap => calculatorSide * 0.04;
  final Curve animationCurve;

  final int keysPerRow = 4;

  double get fontSize => keySideMin * 0.6;

  final double calculatorSide;

  double get calculatorBodyMaxSidesDistance => calculatorSide * 0.28;

  double get calculatorSideWithDistance =>
      calculatorTotalSide + calculatorBodyMaxSidesDistance;

  double get calculatorTotalSide => calculatorSide + calculatorPadding * 2;

  double get calculatorPadding => calculatorSide * 0.04;
  double get keyDownDistance => calculatorPadding * 2;

  double get calculatorVerticalBodyIndent => calculatorPadding * 2.5;

  double get keySideMin =>
      (calculatorSide - (keysGap * (keysPerRow - 1))) / keysPerRow;

  Size get calculatorSize => Size(calculatorSide, calculatorSide);
}
