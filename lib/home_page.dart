import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/widgets/calculator_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      body: Center(
        child: CalculatorView(
          config: CalculatorConfig(
            calculatorSide: 460,
            // This can be used to have the calculator scale with the screen
            // However the performance is not good and some glitches happen
            // calculatorSide: screenSize.width * 0.6,
            keysHaveShadow: true,
          ),
        ),
      ),
    );
  }
}
