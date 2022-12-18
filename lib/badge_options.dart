import 'package:flutter/material.dart';

class BadgeOptions {
  final bool active;
  final double fontSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double width;
  final double height;

  const BadgeOptions({
    this.active = true,
    this.fontSize = 10,
    this.backgroundColor,
    this.foregroundColor,
    this.width = 18,
    this.height = 18,
  });
}
