import 'dart:math';
import 'dart:ui' as ui;

import 'package:calculator_3d/OLD_calculator_config.dart';
import 'package:calculator_3d/constants.dart';
import 'package:flutter/material.dart';

class CalculatorPainter extends CustomPainter {
  CalculatorPainter({
    required this.animation,
    required this.config,
  }) : super(repaint: animation) {
    angleAnimation = Tween<double>(begin: 0, end: 45).animate(
      CurvedAnimation(parent: animation, curve: Constants.curve),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(parent: animation, curve: Constants.curve),
    );

    distanceAnimation = Tween<double>(begin: 10, end: 100).animate(
      CurvedAnimation(parent: animation, curve: Constants.curve),
    );
  }

  final Animation<double> animation;
  final CalculatorConfig config;
  final Size keySize =
      const Size(Constants.squareKeySide, Constants.squareKeySide);

  late Animation<double> angleAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> distanceAnimation;

  final keyFacePath = Path();
  final keyFaceShadowsPath = Path();
  Path keyBodyPath = Path();
  final keyBodyPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    double aspectRatio = keySize.width / keySize.height;
    double keyWidth = keySize.width;
    // (aspectRatio > 1 ? Constants.keysGap : 0) * (1 - animation.value);
    double keyHeight = keySize.height;
    // (aspectRatio < 1 ? Constants.keysGap : 0) * (1 - animation.value);

    double borderRadiusOffset =
        (Constants.keyBorderRadius * sqrt(2) - Constants.keyBorderRadius) /
            sqrt(2);
    double distance = distanceAnimation.value;

    final keyFacePaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, keyHeight / 2),
        Offset(keyWidth, keyHeight),
        [
          Colors.blueGrey.shade100,
          Colors.blueGrey.shade200,
        ],
      );
    final keyFaceShadowPaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);

    for (int i = 0; i <= 8; i++) {
      int itemsPerRow = 3;
      int colIndex = i % itemsPerRow;
      int rowIndex = i ~/ itemsPerRow;

      _drawRRectWithShadow(colIndex, rowIndex);
    }

    _drawRRectWithShadow(0, 3, (keyWidth * 2 + config.keysGap));
    _drawRRectWithShadow(2, 3);
    _drawRRectWithShadow(3, 0, null, (keySize.height * 2 + config.keysGap));
    _drawRRectWithShadow(3, 2, null, (keySize.height * 2 + config.keysGap));

    canvas.translate(
      config.size.width * (1 - scaleAnimation.value),
      config.size.height * 0.5 * (1 - scaleAnimation.value),
    );
    canvas.scale(1, scaleAnimation.value);
    canvas.rotate(angleAnimation.value * pi / 180);
    // canvas.drawPath(
    //   keyFaceShadowsPath,
    //   keyFaceShadowPaint,
    // );
    canvas.drawPath(
      keyFacePath,
      keyFacePaint,
    );
    // final textSpan = TextSpan(
    //   text: value,
    //   style: textStyle,
    // );
    // final textPainter = TextPainter(
    //   text: textSpan,
    //   textDirection: TextDirection.ltr,
    //   textAlign: TextAlign.center,
    // );
    // textPainter.layout(
    //   minWidth: 0,
    //   maxWidth: keyWidth,
    // );
    // final xCenter = keyWidth / 2 - fontSize * 0.4;
    // final yCenter = keyHeight / 2 - fontSize * 0.65;
    // final offset = Offset(xCenter, yCenter);
    // textPainter.paint(canvas, offset);
  }

  void _drawRRectWithShadow(
    int colIndex,
    int rowIndex, [
    double? width,
    double? height,
  ]) {
    keyFacePath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          colIndex * (keySize.width + 10),
          rowIndex * (keySize.height + 10),
          (width ?? keySize.width) - 4,
          (height ?? keySize.height) - 4,
        ),
        const Radius.circular(Constants.keyBorderRadius),
      ),
    );

    keyFaceShadowsPath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          colIndex * (keySize.width + 10),
          rowIndex * (keySize.height + 10),
          width ?? keySize.width,
          height ?? keySize.height,
        ),
        const Radius.circular(Constants.keyBorderRadius),
      ),
    );
  }

  Path _getKeyBodyPath(int colIndex, int rowIndex) {
    double borderRadiusOffset =
        (Constants.keyBorderRadius * sqrt(2) - Constants.keyBorderRadius) /
            sqrt(2);
    double distance = distanceAnimation.value;

    return keyBodyPath
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            colIndex * (keySize.width + 10),
            rowIndex * (keySize.height + 10),
            keySize.width,
            keySize.height,
          ),
          const Radius.circular(Constants.keyBorderRadius),
        ),
      )
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            distance + colIndex * (keySize.width + 10),
            distance + rowIndex * (keySize.height + 10),
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
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      color: Colors.blueGrey.shade700,
      fontSize: config.fontSize,
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
