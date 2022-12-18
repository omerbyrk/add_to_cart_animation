import 'package:flutter/widgets.dart';

class JumpAnimationOptions {
  /// Should the given widget jump before the dragging
  final bool active;

  /// What Should the given widget's duration on jump
  final Duration duration;

  /// What Should the given widget's curve on jump
  final Curve curve;

  const JumpAnimationOptions({
    this.active = true,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.linearToEaseOut,
  });
}
