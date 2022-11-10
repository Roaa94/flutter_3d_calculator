import 'package:calculator_3d/constants.dart';
import 'package:calculator_3d/key_body_painter.dart';
import 'package:calculator_3d/key_face_painter.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: Constants.keySize.width,
            height: Constants.keySize.height,
            child: CustomPaint(
              foregroundPainter: KeyFacePainter(
                '9',
                animation: _animationController,
                keySize: Constants.keySize,
              ),
              painter: KeyBodyPainter(
                animation: _animationController,
                keySize: Constants.keySize,
              ),
            ),
          ),
        ),
        const SizedBox(height: 100),
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
    );
  }
}
