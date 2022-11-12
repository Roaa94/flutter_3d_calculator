import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:flutter/material.dart';

class RimContainer extends StatelessWidget {
  const RimContainer({
    super.key,
    required this.size,
    required this.config,
    required this.glowOffsetAnimation,
    this.child,
  });

  final double size;
  final CalculatorConfig config;
  final Animation<Offset> glowOffsetAnimation;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          config.keyBorderRadius,
        ),
        gradient: LinearGradient(
          colors: [
            config.baseColor.shade300,
            config.baseColor.shade200,
            config.baseColor.shade100,
            config.baseColor.shade50,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: const [0.01, 0.49, 0.52, 0.7],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: glowOffsetAnimation.value,
            blurRadius: 6,
            blurStyle: BlurStyle.solid,
          ),
        ],
      ),
      child: child,
    );
  }
}
