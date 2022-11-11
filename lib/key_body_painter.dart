import 'dart:math';
import 'dart:ui' as ui;

import 'package:calculator_3d/constants.dart';
import 'package:flutter/material.dart';

class KeyBodyPainter extends CustomPainter {
  KeyBodyPainter({
    required this.keySize,
    required this.animation,
  }) : super(repaint: animation) {
    angleAnimation = Tween<double>(begin: 0, end: 45).animate(
      CurvedAnimation(parent: animation, curve: Constants.curve),
    );
    distanceAnimation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: animation, curve: Constants.curve),
    );
    scaleAnimation = Tween<Offset>(
      begin: const Offset(1.1, 1.1),
      end: const Offset(1, 0.5),
    ).animate(
      CurvedAnimation(parent: animation, curve: Constants.curve),
    );
    translateAnimation = Tween<Offset>(
      begin: const Offset(-5, -5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: animation, curve: Constants.curve),
    );
  }

  final Size keySize;
  final Animation<double> animation;

  late Animation<double> angleAnimation;
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
          Colors.blueGrey.shade500,
          Colors.blueGrey.shade300,
          Colors.blueGrey.shade100,
        ],
        [0.01, 0.45, 0.55],
      );

    double borderRadiusOffset =
        (Constants.keyBorderRadius * sqrt(2) - Constants.keyBorderRadius) /
            sqrt(2);
    double distance = distanceAnimation.value;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            0,
            keySize.width,
            keySize.height,
          ),
          const Radius.circular(Constants.keyBorderRadius),
        ),
      )
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            distance,
            distance,
            keySize.width,
            keySize.height,
          ),
          const Radius.circular(Constants.keyBorderRadius),
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
    canvas.rotate(angleAnimation.value * pi / 180);
    canvas.drawShadow(path, Colors.black, 10, false);
    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
