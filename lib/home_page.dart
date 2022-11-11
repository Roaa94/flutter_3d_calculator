import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/widgets/calculator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      body: Calculator(
        config: CalculatorConfig(
          keysGap: 20,
          keySideMin: 100,
          keysHaveShadow: true,
        ),
      ),
    );
  }
}
