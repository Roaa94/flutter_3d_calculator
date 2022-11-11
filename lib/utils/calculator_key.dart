import 'package:flutter/material.dart';

class CalculatorKey {
  CalculatorKey({
    required this.type,
    required this.color,
    required this.size,
  });

  final CalculatorKeyType type;
  final MaterialColor color;
  final Size size;

  // Size get size => Size(keySideMin * type.aspectRatio, keySideMin);

  String get value => type.value;
}

enum CalculatorKeyType {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  zero,
  dot,
  minus,
  plus;

  String get value {
    switch (this) {
      case one:
        return '1';
      case two:
        return '2';
      case three:
        return '3';
      case four:
        return '4';
      case five:
        return '5';
      case six:
        return '6';
      case seven:
        return '7';
      case eight:
        return '8';
      case nine:
        return '9';
      case zero:
        return '0';
      case dot:
        return '.';
      case minus:
        return '-';
      case plus:
        return '+';
    }
  }

  double get aspectRatio {
    switch (this) {
      case one:
      case two:
      case three:
      case four:
      case five:
      case six:
      case seven:
      case eight:
      case nine:
      case dot:
        return 1;
      case zero:
        return 2;
      case minus:
      case plus:
        return 0.5;
    }
  }

  static CalculatorKeyType fromNumber(int number) {
    switch (number) {
      case 1:
        return one;
      case 2:
        return two;
      case 3:
        return three;
      case 4:
        return four;
      case 5:
        return five;
      case 6:
        return six;
      case 7:
        return seven;
      case 8:
        return eight;
      case 9:
      default:
        return nine;
    }
  }
}
