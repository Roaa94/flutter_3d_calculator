import 'dart:math';

import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/utils/calculator_key_data.dart';
import 'package:calculator_3d/widgets/calculator_grid.dart';
import 'package:calculator_3d/widgets/calculator_key.dart';
import 'package:calculator_3d/widgets/key_gesture_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calculator extends StatefulWidget {
  const Calculator({
    super.key,
    required this.config,
  });

  final CalculatorConfig config;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> scaleAnimation;
  final FocusNode keyboardListenerFocusNode = FocusNode();
  CalculatorKeyType? tappedKeyType;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    scaleAnimation =
        Tween<double>(begin: 1, end: 0.5).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: keyboardListenerFocusNode,
      onKey: (node, RawKeyEvent event) {
        if (event is RawKeyDownEvent && animationController.isCompleted) {
          final logicalKey = event.data.logicalKey;
          CalculatorKeyType? calculatorKeyType =
              CalculatorKeyType.getFromKey(logicalKey);
          if (calculatorKeyType != null) {
            setState(() {
              tappedKeyType = calculatorKeyType;
            });
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Builder(builder: (context) {
        FocusScope.of(context).requestFocus(keyboardListenerFocusNode);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
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
                          onTap: () {
                            setState(() {
                              tappedKeyType = key.type;
                            });
                          },
                          child: KeyTapEffect(
                            onEnd: () {
                              setState(() {
                                tappedKeyType = null;
                              });
                            },
                            isTapped: tappedKeyType == key.type,
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
            ),
            ElevatedButton(
              onPressed: () {
                if (animationController.isCompleted) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
              },
              child: const Text('Toggle Animation!'),
            ),
          ],
        );
      }),
    );
  }
}
