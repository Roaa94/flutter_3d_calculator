import 'dart:math';
import 'dart:ui' as ui;

import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:flutter/material.dart';

class KeyBodyPainter extends CustomPainter {
  KeyBodyPainter({
    required this.config,
    required this.keySize,
    required this.animation,
    required this.color,
  }) : super(repaint: animation) {
    distanceAnimation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: animation, curve: config.animationCurve),
    );
    scaleAnimation = Tween<Offset>(
      begin: Offset(
        1 + (config.keysGap * 0.5 / keySize.width),
        1 + (config.keysGap * 0.5 / keySize.height),
      ),
      end: const Offset(1, 1),
    ).animate(
      CurvedAnimation(parent: animation, curve: config.animationCurve),
    );
    translateAnimation = Tween<Offset>(
      begin: Offset(-config.keysGap * 0.25, -config.keysGap * 0.25),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: animation, curve: config.animationCurve),
    );
  }

  final Size keySize;
  final MaterialColor color;
  final CalculatorConfig config;
  final Animation<double> animation;
  late Animation<Offset> scaleAnimation;
  late Animation<double> distanceAnimation;
  late Animation<Offset> translateAnimation;

  @override
  void paint(Canvas canvas, Size size) {
    double aspectRatio = keySize.width / keySize.height;
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, keySize.height),
        Offset(
          keySize.width,
          keySize.height * (1 - aspectRatio),
        ),
        [
          color.shade500,
          color.shade300,
          color.shade100,
        ],
        [0.01, 0.45, 0.55],
      );

    double borderRadiusOffset =
        (config.borderRadius * sqrt(2) - config.borderRadius) / sqrt(2);
    double distance = distanceAnimation.value;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, keySize.width, keySize.height),
          Radius.circular(config.borderRadius),
        ),
      )
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(distance, distance, keySize.width, keySize.height),
          Radius.circular(config.borderRadius),
        ),
      )
      ..moveTo(keySize.width - borderRadiusOffset, borderRadiusOffset)
      ..lineTo(
        keySize.width + distance - borderRadiusOffset,
        distance + borderRadiusOffset,
      )
      ..lineTo(
        distance + borderRadiusOffset,
        keySize.height + distance - borderRadiusOffset,
      )
      ..lineTo(borderRadiusOffset, keySize.height - borderRadiusOffset);
    canvas.translate(translateAnimation.value.dx, translateAnimation.value.dy);
    canvas.scale(scaleAnimation.value.dx, scaleAnimation.value.dy);
    canvas.drawShadow(path, Colors.black, 5, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
