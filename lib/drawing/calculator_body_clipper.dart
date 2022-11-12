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
    double maxDistance = config.calculatorSideWithDistance + config.calculatorPadding * 2 + 20;
    path
      ..moveTo(keysArea, -gapOffset)
      ..lineTo(keysArea, keysArea)
      ..lineTo(-gapOffset, keysArea)
      ..lineTo(-gapOffset, maxDistance)
      ..lineTo(maxDistance, maxDistance)
      ..lineTo(maxDistance, -gapOffset)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
