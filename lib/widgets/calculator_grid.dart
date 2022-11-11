import 'package:calculator_3d/utils/calculator_config.dart';
import 'package:calculator_3d/utils/calculator_key.dart';
import 'package:flutter/material.dart';

typedef KeyBuilder = Widget Function(
  BuildContext context,
  CalculatorKey key,
);

class CalculatorGrid extends StatelessWidget {
  const CalculatorGrid({
    super.key,
    required this.keyBuilder,
    required this.config,
  });

  final KeyBuilder keyBuilder;
  final CalculatorConfig config;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: config.calculatorWidth,
      height: config.calculatorHeight,
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(
                width: 300 + config.keysGap * 2,
                height: 300 + config.keysGap * 2,
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: config.keysGap,
                  mainAxisSpacing: config.keysGap,
                  children: List.generate(
                    9,
                    (index) {
                      return keyBuilder(
                        context,
                        CalculatorKey(
                          type: CalculatorKeyType.fromNumber(index + 1),
                          color: config.baseColor,
                          size: Size(config.keySideMin, config.keySideMin),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: config.keysGap),
              Row(
                children: [
                  keyBuilder(
                    context,
                    CalculatorKey(
                      type: CalculatorKeyType.zero,
                      color: config.baseColor,
                      size: Size(config.keySideMin * 2 + config.keysGap,
                          config.keySideMin),
                    ),
                  ),
                  SizedBox(width: config.keysGap),
                  keyBuilder(
                    context,
                    CalculatorKey(
                      type: CalculatorKeyType.dot,
                      color: config.baseColor,
                      size: Size(config.keySideMin, config.keySideMin),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: config.keysGap),
          Column(
            children: [
              keyBuilder(
                context,
                CalculatorKey(
                  type: CalculatorKeyType.plus,
                  color: Colors.orange,
                  size: Size(
                    config.keySideMin,
                    config.keySideMin * 2 + config.keysGap,
                  ),
                ),
              ),
              SizedBox(height: config.keysGap),
              keyBuilder(
                context,
                CalculatorKey(
                  type: CalculatorKeyType.minus,
                  color: Colors.orange,
                  size: Size(
                    config.keySideMin,
                    config.keySideMin * 2 + config.keysGap,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
