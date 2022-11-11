import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/utils/calculator_key_data.dart';
import 'package:calculator_3d/widgets/calculator_key_face.dart';
import 'package:calculator_3d/widgets/key_body_painter.dart';
import 'package:flutter/material.dart';

class CalculatorKey extends StatelessWidget {
  const CalculatorKey({
    super.key,
    required this.keyData,
    required this.animationController,
    required this.calculatorConfig,
  });

  final CalculatorKeyData keyData;
  final AnimationController animationController;
  final CalculatorConfig calculatorConfig;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: calculatorConfig.keysHaveShadow
            ? [
                BoxShadow(
                  color: calculatorConfig.keysShadowColor,
                  blurRadius: 10,
                  offset: Offset(
                    -5 * animationController.value,
                    20 * animationController.value,
                  ),
                ),
                BoxShadow(
                  color: calculatorConfig.keysShadowColor,
                  blurRadius: 10,
                  offset: Offset(
                    15 * animationController.value,
                    35 * animationController.value,
                  ),
                ),
                BoxShadow(
                  color: calculatorConfig.keysShadowColor,
                  blurRadius: 10,
                  offset: Offset(
                    30 * animationController.value,
                    50 * animationController.value,
                  ),
                ),
              ]
            : [],
      ),
      child: SizedBox(
        width: keyData.size.width,
        height: keyData.size.height,
        child: Stack(
          children: [
            CustomPaint(
              painter: KeyBodyPainter(
                keySize: keyData.size,
                config: calculatorConfig,
                animation: animationController,
                color: keyData.color,
              ),
            ),
            CalculatorKeyFace(
              size: keyData.size,
              value: keyData.value,
              config: calculatorConfig,
              color: keyData.color,
              animationController: animationController,
            ),
          ],
        ),
      ),
    );
  }
}
