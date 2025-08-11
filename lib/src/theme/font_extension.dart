import 'package:flutter/material.dart';

final class FontsExtension extends ThemeExtension<FontsExtension> {
  FontsExtension({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.subtitle,
    required this.body,
    required this.small,
  });

  factory FontsExtension.fallback() => FontsExtension(
    h1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    h2: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    h3: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    h4: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    h5: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    h6: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    subtitle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    body: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    small: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
  );

  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle h5;
  final TextStyle h6;
  final TextStyle subtitle;
  final TextStyle body;
  final TextStyle small;

  @override
  ThemeExtension<FontsExtension> copyWith() => this;

  @override
  ThemeExtension<FontsExtension> lerp(covariant ThemeExtension<FontsExtension>? other, double t) => this;
}
