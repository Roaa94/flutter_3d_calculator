import 'dart:math';

import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/utils/calculator_key_data.dart';
import 'package:calculator_3d/drawing/calculator_body_clipper.dart';
import 'package:calculator_3d/drawing/calculator_body_painter.dart';
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
  late final Animation<Offset> glowOffsetAnimation;

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

    glowOffsetAnimation = Tween<Offset>(
      begin: const Offset(2, 2),
      end: const Offset(4, 4),
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
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

        double rimSide = widget.config.calculatorTotalSide +
            widget.config.calculatorPadding +
            (widget.config.calculatorPadding * animationController.value);

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
                            glowOffsetAnimation: glowOffsetAnimation,
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
                      child: Center(
                        child: Container(
                          width: rimSide,
                          height: rimSide,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              widget.config.keyBorderRadius,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                widget.config.baseColor.shade300,
                                widget.config.baseColor.shade200,
                                widget.config.baseColor.shade100,
                                widget.config.baseColor.shade50,
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
                        ),
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
