import 'package:flutter/material.dart';

class KeyTapEffect extends StatelessWidget {
  const KeyTapEffect({
    super.key,
    this.onEnd,
    required this.child,
    this.isTapped = false,
    required this.in3d,
  });

  final VoidCallback? onEnd;
  final Widget child;
  final bool isTapped;
  final bool in3d;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      tween: Tween<double>(
        begin: 0,
        end: isTapped ? (in3d ? 40 : -0.15) : 0,
      ),
      onEnd: onEnd,
      child: child,
      builder: (context, double value, child) {
        if (in3d) {
          return Transform.translate(
            offset: Offset(value, value),
            child: child,
          );
        } else {
          return Transform.scale(
            scale: 1 + value,
            child: child,
          );
        }
      },
    );
  }
}
