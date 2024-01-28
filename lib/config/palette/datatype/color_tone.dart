import 'package:flutter/material.dart';
import 'package:kap/config/theme/theme_scheme.dart';

class ColorTone extends ColorSwatch<ThemeScheme> {
  const ColorTone(super.primary, super.swatch);

  Color get dark => this[ThemeScheme.dark]!;

  Color get light => this[ThemeScheme.light]!;
}
