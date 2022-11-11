import 'package:flutter/material.dart';

class KeyTapEffect extends StatelessWidget {
  const KeyTapEffect({
    super.key,
    this.onEnd,
    required this.child,
    this.isTapped = false,
  });

  final VoidCallback? onEnd;
  final Widget child;
  final bool isTapped;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 0, end: isTapped ? 40 : 0),
      onEnd: onEnd,
      child: child,
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(value, value),
          child: child,
        );
      },
    );
  }
}
