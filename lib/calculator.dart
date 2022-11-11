import 'package:calculator_3d/calculator_key.dart';
import 'package:calculator_3d/constants.dart';
import 'package:flutter/material.dart';

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
                final totalKeyWidth =
                    Constants.squareKeySize.width + Constants.keysGap;
                final totalKeyHeight =
                    Constants.squareKeySize.height + Constants.keysGap;
                return ColoredBox(
                  color: Colors.red,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      ...List.generate(
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
                            child: CalculatorKey(
                              value: '${index + 1}',
                              animationController: _animationController,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: totalKeyHeight * 3,
                        left: 0,
                        child: CalculatorKey(
                          value: '0',
                          size: Constants.recHKeySize,
                          animationController: _animationController,
                        ),
                      ),
                      Positioned(
                        top: totalKeyHeight * 3,
                        left: totalKeyWidth * 2,
                        child: CalculatorKey(
                          animationController: _animationController,
                          value: '.',
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: totalKeyWidth * 3,
                        child: CalculatorKey(
                          size: Constants.recVKeySize,
                          animationController: _animationController,
                          value: '+',
                        ),
                      ),
                      Positioned(
                        top: totalKeyWidth * 2,
                        left: totalKeyWidth * 3,
                        child: CalculatorKey(
                          value: '-',
                          size: Constants.recVKeySize,
                          animationController: _animationController,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
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
