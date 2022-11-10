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
            width: 100,
            height: 100,
            child: CustomPaint(
              foregroundPainter: KeyFacePainter(
                '9',
                animation: _animationController,
              ),
              painter: KeyBodyPainter(),
            ),
          ),
        ),
      ],
    );
  }
}
