import 'package:calculator_3d/drawing/calculator_body_clipper.dart';
import 'package:calculator_3d/drawing/calculator_body_painter.dart';
import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/widgets/rim_container.dart';
import 'package:flutter/material.dart';

class CalculatorBodyFront extends StatelessWidget {
  const CalculatorBodyFront({
    super.key,
    required this.config,
    required this.animationController,
    required this.rimSide,
    required this.glowOffsetAnimation,
  });

  final CalculatorConfig config;
  final AnimationController animationController;
  final Animation<Offset> glowOffsetAnimation;
  final double rimSide;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CalculatorBodyClipper(config: config),
      child: CustomPaint(
        painter: CalculatorBodyPainter(
          config: config,
          animationController: animationController,
        ),
        child: Center(
          child: RimContainer(
            config: config,
            glowOffsetAnimation: glowOffsetAnimation,
            size: rimSide,
          ),
        ),
      ),
    );
  }
}
