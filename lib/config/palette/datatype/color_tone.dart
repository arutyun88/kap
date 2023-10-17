import 'package:flutter/material.dart';
import 'package:kap/config/palette/datatype/color_type.dart';

class ColorTone extends ColorSwatch<ColorType> {
  const ColorTone(super.primary, super.swatch);

  Color get dark => this[ColorType.dark]!;

  Color get medium => this[ColorType.medium]!;

  Color get light => this[ColorType.light]!;
}
