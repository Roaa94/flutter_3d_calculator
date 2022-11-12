import 'dart:math';

import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:flutter/cupertino.dart';

class CalculatorBodyClipper extends CustomClipper<Path> {
  CalculatorBodyClipper({
    required this.config,
    this.animationController,
  }) : super(reclip: animationController);

  final AnimationController? animationController;
  final CalculatorConfig config;
  final path = Path();

  @override
  Path getClip(Size size) {
    double gapOffset = config.keysGap * 0.5;
    double keysArea =
        config.calculatorSide + config.keysGap + config.calculatorPadding * 2;
    double maxDistance =
        config.calculatorSideWithDistance + config.calculatorPadding * 2 + 20;
    path
      ..moveTo(keysArea, -gapOffset) // 1
      ..lineTo(keysArea, keysArea - config.borderRadius) // 2 - 1
      ..arcTo(
        Rect.fromPoints(
          Offset(keysArea - config.borderRadius, keysArea),
          Offset(keysArea, keysArea - config.borderRadius),
        ),
        0,
        90 * pi / 180,
        false,
      ) // 2 - 2
      // ..lineTo(keysArea - 15, keysArea) // 2 - 2
      ..lineTo(-gapOffset, keysArea) // 3
      ..lineTo(-gapOffset, maxDistance) // 4
      ..lineTo(maxDistance, maxDistance) // 5
      ..lineTo(maxDistance, -gapOffset) // 6
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
