import 'package:calculator_3d/constants.dart';
import 'package:calculator_3d/key_body_painter.dart';
import 'package:flutter/material.dart';

import 'key_face_painter.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final totalKeyWidth = Constants.keySize.width *
                      (1 + Constants.keyBodyScaleDifference);
                  final totalKeyHeight = Constants.keySize.height *
                      (1 + Constants.keyBodyScaleDifference);
                  return Transform.translate(
                    offset: Offset(
                        totalKeyWidth * 3 * _animationController.value, 0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: List.generate(
                        9,
                        (index) {
                          int itemsPerRow = 3;
                          int colIndex = index % itemsPerRow;
                          int rowIndex = index ~/ itemsPerRow;

                          double defaultLeft = colIndex * totalKeyWidth;
                          double defaultTop = rowIndex * totalKeyHeight;

                          double left = defaultLeft -
                              ((colIndex * 25 - rowIndex * 20) *
                                  _animationController.value) -
                              (defaultTop * _animationController.value);

                          double top = defaultTop +
                              (((defaultLeft * 0.5) -
                                      (defaultTop * 0.5) -
                                      colIndex * 15 -
                                      rowIndex * 15) *
                                  _animationController.value);

                          return Positioned(
                            left: left,
                            top: top,
                            child: SizedBox(
                              width: Constants.keySize.width,
                              height: Constants.keySize.height,
                              child: CustomPaint(
                                foregroundPainter: KeyFacePainter(
                                  '${index + 1}',
                                  animation: _animationController,
                                  keySize: Constants.keySize,
                                ),
                                painter: KeyBodyPainter(
                                  animation: _animationController,
                                  keySize: Constants.keySize,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          ),
          ElevatedButton(
            onPressed: () {
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
            },
            child: const Text('Toggle Animation!'),
          ),
        ],
      ),
    );
  }
}
