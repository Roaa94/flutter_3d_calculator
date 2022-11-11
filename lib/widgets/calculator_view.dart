import 'dart:math';

import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/utils/calculator_key_data.dart';
import 'package:calculator_3d/widgets/calculator_grid.dart';
import 'package:calculator_3d/widgets/calculator_key.dart';
import 'package:calculator_3d/widgets/key_gesture_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    animationController.forward();
    scaleAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(
        parent: animationController,
        curve: widget.config.animationCurve,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Transform.scale(
          scaleY: scaleAnimation.value,
          child: Transform(
            transform: Matrix4.identity()
              ..rotateZ((45 * animationController.value) * pi / 180),
            alignment: Alignment.center,
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
        ),
      ),
    );
  }
}
