import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CustomPaint(
                foregroundPainter: KeyFacePainter(),
                painter: KeyBodyPainter(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              height: 150,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    top: 50,
                    bottom: 0,
                    left: -16,
                    right: -16,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueGrey.shade500,
                            Colors.blueGrey.shade300,
                            Colors.blueGrey.shade100,
                          ],
                          stops: const [0.01, 0.45, 0.55],
                        ),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scaleY: 0.5,
                    child: Transform(
                      transform: Matrix4.identity()..rotateZ(45 * pi / 180),
                      alignment: Alignment.center,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(width: 2, color: Colors.transparent),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.blueGrey.shade200,
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.white,
                              offset: Offset(4, 4),
                              blurStyle: BlurStyle.solid,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '9',
                            style: TextStyle(
                              fontSize: 70,
                              color: Colors.blueGrey.shade700,
                              fontWeight: FontWeight.bold,
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
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KeyFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final keyFacePaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, size.height / 2),
        Offset(size.width, size.height),
        [
          Colors.blueGrey.shade100,
          Colors.blueGrey.shade200,
        ],
      );
    final keyFaceShadowPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);
    final keyFacePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            0,
            size.width - 5,
            size.height - 5,
          ),
          const Radius.circular(borderRadius),
        ),
      );
    final keyFaceShadowPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            0,
            size.width,
            size.height,
          ),
          const Radius.circular(borderRadius),
        ),
      );
    canvas.scale(1, 0.5);
    canvas.rotate(45 * pi / 180);
    canvas.drawPath(
      keyFaceShadowPath,
      keyFaceShadowPaint,
    );
    canvas.drawPath(
      keyFacePath,
      keyFacePaint,
    );
    final fontSize = size.width * 0.6;
    final textStyle = TextStyle(
      color: Colors.blueGrey.shade700,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      shadows: [
        BoxShadow(
          blurRadius: 0,
          offset: Offset(4, 4),
          color: Colors.blueGrey.shade900,
          blurStyle: BlurStyle.solid,
        ),
        BoxShadow(
          blurRadius: 0,
          offset: Offset(2, 2),
          color: Colors.blueGrey.shade900,
          blurStyle: BlurStyle.solid,
        ),
      ],
    );
    final textSpan = TextSpan(
      text: '9',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = size.width / 2 - fontSize * 0.4;
    final yCenter = size.height / 2 - fontSize * 0.65;
    final offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

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
        (borderRadius * sqrt(2) - borderRadius) / sqrt(2);
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
          const Radius.circular(borderRadius),
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
          const Radius.circular(borderRadius),
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

const double borderRadius = 15;
