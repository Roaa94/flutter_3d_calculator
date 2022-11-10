import 'dart:math';
import 'dart:ui' as ui;

import 'package:calculator_3d/constants.dart';
import 'package:flutter/material.dart';

class KeyBodyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, size.height),
        Offset(size.width, 0),
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
    double distance = 100;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            0,
            size.width,
            size.height,
          ),
          const Radius.circular(Constants.keyBorderRadius),
        ),
      )
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            distance,
            distance,
            size.width,
            size.height,
          ),
          const Radius.circular(Constants.keyBorderRadius),
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
    canvas.scale(1, 0.5);
    canvas.rotate(45 * pi / 180);
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
