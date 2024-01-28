import 'dart:ui';

import 'package:kap/config/palette/datatype/color_tone.dart';
import 'package:kap/config/theme/theme_scheme.dart';

class SupportPalette {
  final ColorTone success = const ColorTone(
    0xFF007724,
    <ThemeScheme, Color>{
      ThemeScheme.dark: Color(0xFF007724),
      ThemeScheme.light: Color(0xFFB8F1C9),
    },
  );

  final ColorTone warning = const ColorTone(
    0xFFBB8C00,
    <ThemeScheme, Color>{
      ThemeScheme.dark: Color(0xFFBB8C00),
      ThemeScheme.light: Color(0xFFFFE69C),
    },
  );

  final ColorTone info = const ColorTone(
    0xFF0A4CAA,
    <ThemeScheme, Color>{
      ThemeScheme.dark: Color(0xFF0A4CAA),
      ThemeScheme.light: Color(0xFFBBD7FF),
    },
  );

  final Color danger = const Color(0xFFC1271B);
}
