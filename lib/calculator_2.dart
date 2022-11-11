import 'package:calculator_3d/OLD_calculator_config.dart';
import 'package:calculator_3d/calculator_painter.dart';
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(100),
        child: Column(
          children: [
            ColoredBox(
              color: Colors.red,
              child: SizedBox(
                width: Constants.calculatorWidth,
                height: Constants.calculatorHeight,
                child: CustomPaint(
                  painter: CalculatorPainter(
                    animation: _animationController,
                    config: const CalculatorConfig(
                      size: Constants.calculatorSize,
                      fontSize: Constants.keyTextFontSize,
                      keysGap: Constants.keysGap,
                    ),
                  ),
                ),
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
      ),
    );
  }
}
