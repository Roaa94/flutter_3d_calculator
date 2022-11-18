import 'dart:math';

import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/utils/calculator_key_data.dart';
import 'package:calculator_3d/widgets/calculator_body_back.dart';
import 'package:calculator_3d/widgets/calculator_body_front.dart';
import 'package:calculator_3d/widgets/calculator_grid.dart';
import 'package:calculator_3d/widgets/calculator_key.dart';
import 'package:calculator_3d/widgets/key_tap_effect.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({
    super.key,
    required this.config,
    required this.animationController,
    required this.onKeyDown,
    required this.onKeyUp,
    required this.currentTappedKeys,
  });

  final CalculatorConfig config;
  final AnimationController animationController;
  final ValueChanged<CalculatorKeyType> onKeyDown;
  final ValueChanged<CalculatorKeyType> onKeyUp;
  final Set<CalculatorKeyType> currentTappedKeys;

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
    if (widget.config.startAt3D) {
      animationController.value = 1;
    }
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
          alignment: Alignment.center,
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
                  child: CalculatorBodyBack(
                    config: widget.config,
                    glowOffsetAnimation: glowOffsetAnimation,
                    rimSide: rimSide,
                    animationController: animationController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(widget.config.calculatorPadding),
                  child: CalculatorGrid(
                    config: widget.config,
                    keyBuilder: (context, CalculatorKeyData key) {
                      return GestureDetector(
                        onTapDown: (_) => widget.onKeyDown(key.type),
                        onTapUp: (_) => widget.onKeyUp(key.type),
                        onTapCancel: () => widget.onKeyUp(key.type),
                        child: KeyTapEffect(
                          config: widget.config,
                          in3d: animationController.isCompleted,
                          isTapped: widget.currentTappedKeys.contains(key.type),
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
                  child: CalculatorBodyFront(
                    config: widget.config,
                    glowOffsetAnimation: glowOffsetAnimation,
                    rimSide: rimSide,
                    animationController: animationController,
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
