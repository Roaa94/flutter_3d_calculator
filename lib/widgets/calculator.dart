import 'dart:math';

import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/utils/calculator_key.dart';
import 'package:calculator_3d/widgets/calculator_grid.dart';
import 'package:calculator_3d/widgets/calculator_key_face.dart';
import 'package:calculator_3d/widgets/key_body_painter.dart';
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
  final FocusNode focusNode = FocusNode();
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
    return KeyboardListener(
      focusNode: focusNode,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          print(event);
        }
      },
      child: Column(
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
                  child: Stack(
                    children: [
                      CalculatorGrid(
                        config: widget.config,
                        keyBuilder: (context, CalculatorKey key) {
                          return KeyTapEffect(
                            isTapped: tappedKeyType == key.type,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: widget.config.keysHaveShadow
                                    ? [
                                        BoxShadow(
                                          color: widget.config.keysShadowColor,
                                          blurRadius: 10,
                                          offset: Offset(
                                            -5 * animationController.value,
                                            20 * animationController.value,
                                          ),
                                        ),
                                        BoxShadow(
                                          color: widget.config.keysShadowColor,
                                          blurRadius: 10,
                                          offset: Offset(
                                            15 * animationController.value,
                                            35 * animationController.value,
                                          ),
                                        ),
                                        BoxShadow(
                                          color: widget.config.keysShadowColor,
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
                                width: key.size.width,
                                height: key.size.height,
                                child: CustomPaint(
                                  painter: KeyBodyPainter(
                                    keySize: key.size,
                                    config: widget.config,
                                    animation: animationController,
                                    color: key.color,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      CalculatorGrid(
                        config: widget.config,
                        keyBuilder: (context, CalculatorKey key) {
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
                              child: CalculatorKeyFace(
                                size: key.size,
                                value: key.value,
                                config: widget.config,
                                color: key.color,
                                animationController: animationController,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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
      ),
    );
  }
}
