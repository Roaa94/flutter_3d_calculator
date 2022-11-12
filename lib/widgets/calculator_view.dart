import 'dart:math';

import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/utils/calculator_key_data.dart';
import 'package:calculator_3d/widgets/calculator_body_clipper.dart';
import 'package:calculator_3d/widgets/calculator_body_painter.dart';
import 'package:calculator_3d/widgets/calculator_grid.dart';
import 'package:calculator_3d/widgets/calculator_key.dart';
import 'package:calculator_3d/widgets/key_gesture_detector.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({
    super.key,
    required this.config,
    required this.animationController,
    required this.onKeyTap,
    required this.onKeyAnimationEnd,
    required this.currentTappedKey,
  });

  final CalculatorConfig config;
  final AnimationController animationController;
  final ValueChanged<CalculatorKeyType> onKeyTap;
  final VoidCallback onKeyAnimationEnd;
  final CalculatorKeyType? currentTappedKey;

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    animationController = widget.animationController;
    // animationController.forward();
    scaleAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(
        parent: animationController,
        curve: widget.config.animationCurve,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        double bodyOffset = widget.config.calculatorVerticalBodyIndent *
            animationController.value;

        return Transform.scale(
          scaleY: scaleAnimation.value,
          child: Transform(
            transform: Matrix4.identity()
              ..rotateZ((45 * animationController.value) * pi / 180),
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: bodyOffset - widget.config.calculatorPadding,
                  top: bodyOffset - widget.config.calculatorPadding,
                  right: -(bodyOffset + widget.config.calculatorPadding),
                  bottom: -(bodyOffset + widget.config.calculatorPadding),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.config.baseColor.shade700,
                      borderRadius: BorderRadius.circular(
                        widget.config.keyBorderRadius,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(widget.config.calculatorPadding),
                  child: CalculatorGrid(
                    config: widget.config,
                    keyBuilder: (context, CalculatorKeyData key) {
                      return GestureDetector(
                        onTap: () => widget.onKeyTap(key.type),
                        child: KeyTapEffect(
                          in3d: animationController.isCompleted,
                          onEnd: widget.onKeyAnimationEnd,
                          isTapped: widget.currentTappedKey == key.type,
                          child: CalculatorKey(
                            keyData: key,
                            calculatorConfig: widget.config,
                            animationController: animationController,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  left: bodyOffset - widget.config.calculatorPadding,
                  top: bodyOffset - widget.config.calculatorPadding,
                  right: -(bodyOffset + widget.config.calculatorPadding),
                  bottom: -(bodyOffset + widget.config.calculatorPadding),
                  child: ClipPath(
                    clipper: CalculatorBodyClipper(config: widget.config),
                    child: CustomPaint(
                      painter: CalculatorBodyPainter(
                        config: widget.config,
                        animationController: animationController,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
