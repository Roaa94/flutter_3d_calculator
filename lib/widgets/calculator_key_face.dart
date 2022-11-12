import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:flutter/material.dart';

class CalculatorKeyFace extends StatefulWidget {
  const CalculatorKeyFace({
    super.key,
    required this.size,
    required this.value,
    required this.config,
    required this.color,
    required this.animationController,
    required this.glowOffsetAnimation,
  });

  final Size size;
  final String value;
  final CalculatorConfig config;
  final MaterialColor color;
  final AnimationController animationController;
  final Animation<Offset> glowOffsetAnimation;

  @override
  State<CalculatorKeyFace> createState() => _CalculatorKeyFaceState();
}

class _CalculatorKeyFaceState extends State<CalculatorKeyFace> {
  late final Animation<double> textShadowOffsetAnimation;

  @override
  void initState() {
    textShadowOffsetAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: widget.config.animationCurve,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            widget.color.shade50,
            widget.color.shade200,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: widget.glowOffsetAnimation.value,
            blurRadius: 6,
            blurStyle: BlurStyle.solid,
          ),
        ],
      ),
      child: Center(
        child: Stack(
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  widget.config.baseColor.shade900,
                  widget.config.baseColor.shade900,
                  widget.config.baseColor.shade100,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: const [0, 0.3, 0.8],
              ).createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                widget.value,
                style: TextStyle(
                  fontSize: widget.config.fontSize,
                  fontWeight: FontWeight.w700,
                  shadows: [
                    BoxShadow(
                      blurRadius: 0,
                      offset: Offset(
                        4 * textShadowOffsetAnimation.value,
                        4 * textShadowOffsetAnimation.value,
                      ),
                      color: widget.config.baseColor.shade900,
                      blurStyle: BlurStyle.solid,
                    ),
                    BoxShadow(
                      blurRadius: 0,
                      offset: Offset(
                        3 * textShadowOffsetAnimation.value,
                        3 * textShadowOffsetAnimation.value,
                      ),
                      color: widget.config.baseColor.shade900,
                      blurStyle: BlurStyle.solid,
                    ),
                    BoxShadow(
                      blurRadius: 0,
                      offset: Offset(
                        2 * textShadowOffsetAnimation.value,
                        2 * textShadowOffsetAnimation.value,
                      ),
                      color: widget.config.baseColor.shade900,
                      blurStyle: BlurStyle.solid,
                    ),
                  ],
                ),
              ),
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  widget.config.baseColor.shade200,
                  widget.config.baseColor.shade400,
                  widget.config.baseColor.shade600,
                ],
                end: Alignment.bottomLeft,
                begin: Alignment.topRight,
                stops: const [0, 0.3, 0.5],
              ).createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                widget.value,
                style: TextStyle(
                  fontSize: widget.config.fontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
