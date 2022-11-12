import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/widgets/rim_container.dart';
import 'package:flutter/material.dart';

class CalculatorBodyBack extends StatelessWidget {
  const CalculatorBodyBack({
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            config.baseColor.shade700,
            config.baseColor.shade500,
            config.baseColor.shade300,
            config.baseColor.shade200,
            config.baseColor.shade100,
            config.baseColor.shade50,
          ],
          stops: const [0.01, 0.2, 0.49, 0.52, 0.6, 0.9],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(
          config.keyBorderRadius,
        ),
      ),
      child: Center(
        child: RimContainer(
          config: config,
          glowOffsetAnimation: glowOffsetAnimation,
          size: rimSide,
          child: Container(
            margin: EdgeInsets.all(
              config.calculatorPadding * 0.8,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  config.baseColor.shade900,
                  config.baseColor.shade500,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(
                config.keyBorderRadius,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  config.keyBorderRadius,
                ),
                gradient: LinearGradient(
                  colors: [
                    config.baseColor.shade900,
                    config.baseColor.shade500,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 4,
                    blurStyle: BlurStyle.solid,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
