import 'package:calculator_3d/constants.dart';
import 'package:calculator_3d/key_body_painter.dart';
import 'package:calculator_3d/key_face_painter.dart';
import 'package:flutter/material.dart';

class CalculatorKey extends StatelessWidget {
  const CalculatorKey({
    super.key,
    this.size = Constants.squareKeySize,
    required this.animationController,
    required this.value,
  });

  final Size size;
  final AnimationController animationController;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: CustomPaint(
        foregroundPainter: KeyFacePainter(
          value,
          animation: animationController,
          keySize: size,
        ),
        painter: KeyBodyPainter(
          animation: animationController,
          keySize: size,
        ),
      ),
    );
  }
}
