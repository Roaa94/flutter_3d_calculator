import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorKeyData {
  CalculatorKeyData({
    required this.type,
    required this.color,
    required this.size,
  });

  final CalculatorKeyType type;
  final MaterialColor color;
  final Size size;

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

  static CalculatorKeyType? getFromKey(LogicalKeyboardKey key) {
    if (key == LogicalKeyboardKey.digit0 || key == LogicalKeyboardKey.numpad0) {
      return CalculatorKeyType.zero;
    } else if (key == LogicalKeyboardKey.digit1 ||
        key == LogicalKeyboardKey.numpad1) {
      return CalculatorKeyType.one;
    } else if (key == LogicalKeyboardKey.digit2 ||
        key == LogicalKeyboardKey.numpad2) {
      return CalculatorKeyType.two;
    } else if (key == LogicalKeyboardKey.digit3 ||
        key == LogicalKeyboardKey.numpad3) {
      return CalculatorKeyType.three;
    } else if (key == LogicalKeyboardKey.digit4 ||
        key == LogicalKeyboardKey.numpad4) {
      return CalculatorKeyType.four;
    } else if (key == LogicalKeyboardKey.digit5 ||
        key == LogicalKeyboardKey.numpad5) {
      return CalculatorKeyType.five;
    } else if (key == LogicalKeyboardKey.digit6 ||
        key == LogicalKeyboardKey.numpad6) {
      return CalculatorKeyType.six;
    } else if (key == LogicalKeyboardKey.digit7 ||
        key == LogicalKeyboardKey.numpad7) {
      return CalculatorKeyType.seven;
    } else if (key == LogicalKeyboardKey.digit8 ||
        key == LogicalKeyboardKey.numpad8) {
      return CalculatorKeyType.eight;
    } else if (key == LogicalKeyboardKey.digit9 ||
        key == LogicalKeyboardKey.numpad9) {
      return CalculatorKeyType.nine;
    } else if (key == LogicalKeyboardKey.add ||
        key == LogicalKeyboardKey.numpadAdd) {
      return CalculatorKeyType.plus;
    } else if (key == LogicalKeyboardKey.minus ||
        key == LogicalKeyboardKey.numpadSubtract) {
      return CalculatorKeyType.minus;
    } else if (key == LogicalKeyboardKey.period ||
        key == LogicalKeyboardKey.numpadDecimal) {
      return CalculatorKeyType.dot;
    } else {
      return null;
    }
  }
}
