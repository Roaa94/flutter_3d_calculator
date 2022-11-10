import 'dart:math';
import 'dart:ui' as ui;

import 'package:calculator_3d/constants.dart';
import 'package:flutter/material.dart';

class KeyFacePainter extends CustomPainter {
  KeyFacePainter(
    this.value, {
    required this.animation,
    required this.keySize,
  }) : super(repaint: animation) {
    angleAnimation = Tween<double>(begin: 0, end: 45).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeInOut),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeInOut),
    );
  }

  final Animation<double> animation;
  final String value;
  final Size keySize;

  late Animation<double> angleAnimation;
  late Animation<double> scaleAnimation;

  @override
  void paint(Canvas canvas, Size size) {
    final keyFacePaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, keySize.height / 2),
        Offset(keySize.width, keySize.height),
        [
          Colors.blueGrey.shade100,
          Colors.blueGrey.shade200,
        ],
      );
    final keyFaceShadowPaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);
    final keyFacePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            0,
            keySize.width - 4,
            keySize.height - 4,
          ),
          const Radius.circular(Constants.keyBorderRadius),
        ),
      );
    final keyFaceShadowPath = Path()
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
      );
    canvas.scale(1, scaleAnimation.value);
    canvas.rotate(angleAnimation.value * pi / 180);
    canvas.drawPath(
      keyFaceShadowPath,
      keyFaceShadowPaint,
    );
    canvas.drawPath(
      keyFacePath,
      keyFacePaint,
    );
    final fontSize = keySize.width * 0.6;
    final textStyle = TextStyle(
      color: Colors.blueGrey.shade700,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      shadows: [
        BoxShadow(
          blurRadius: 0,
          offset: const Offset(4, 4),
          color: Colors.blueGrey.shade900,
          blurStyle: BlurStyle.solid,
        ),
        BoxShadow(
          blurRadius: 0,
          offset: const Offset(2, 2),
          color: Colors.blueGrey.shade900,
          blurStyle: BlurStyle.solid,
        ),
      ],
    );
    final textSpan = TextSpan(
      text: value,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: keySize.width,
    );
    final xCenter = keySize.width / 2 - fontSize * 0.4;
    final yCenter = keySize.height / 2 - fontSize * 0.65;
    final offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
