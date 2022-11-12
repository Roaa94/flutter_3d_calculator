import 'dart:math';
import 'dart:ui' as ui;

import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:flutter/material.dart';

class CalculatorBodyPainter extends CustomPainter {
  CalculatorBodyPainter({
    required this.config,
    required this.animationController,
  }) : super(repaint: animationController) {
    distanceAnimation = Tween<double>(
      begin: 0,
      end: config.calculatorBodyMaxSidesDistance,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: config.animationCurve,
      ),
    );
  }

  final CalculatorConfig config;
  final AnimationController animationController;
  late Animation<double> distanceAnimation;
  late Animation<double> rimOffsetAnimation;

  final bodyPaint = Paint();
  final rimPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    bodyPaint.shader = ui.Gradient.linear(
      Offset(0, config.calculatorSideWithDistance),
      Offset(config.calculatorSideWithDistance, 0),
      [
        config.baseColor.shade700,
        config.baseColor.shade500,
        config.baseColor.shade300,
        config.baseColor.shade200,
        config.baseColor.shade100,
        config.baseColor.shade50,
      ],
      [0.01, 0.2, 0.49, 0.52, 0.6, 0.9],
    );
    double borderRadiusOffset =
        (config.keyBorderRadius * sqrt(2) - config.keyBorderRadius) / sqrt(2);
    double distance = distanceAnimation.value;
    final bodyPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(config.keyBorderRadius),
        ),
      )
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(distance, distance, size.width, size.height),
          Radius.circular(config.keyBorderRadius),
        ),
      )
      ..moveTo(size.width - borderRadiusOffset, borderRadiusOffset)
      ..lineTo(
        size.width + distance - borderRadiusOffset,
        distance + borderRadiusOffset,
      )
      ..lineTo(
        distance + borderRadiusOffset,
        size.height + distance - borderRadiusOffset,
      )
      ..lineTo(borderRadiusOffset, size.height - borderRadiusOffset);
    canvas.drawPath(bodyPath, bodyPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
