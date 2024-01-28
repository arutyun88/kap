import 'dart:ui';

import 'package:kap/config/palette/datatype/color_tone.dart';
import 'package:kap/config/theme/theme_scheme.dart';
import 'package:kap/config/palette/main_palette.dart';
import 'package:kap/config/palette/support_palette.dart';

abstract class Palette {
  static const Color accent = Color(0xFFFF9726);

  static const ColorTone background = ColorTone(
    0xFF150C2F,
    <ThemeScheme, Color>{
      ThemeScheme.dark: Color.fromRGBO(30, 30, 40, 1),
      ThemeScheme.light: Color.fromRGBO(255, 255, 255, 1),
    },
  );

  static const ColorTone bottomNavigationBarBackgroundColor = ColorTone(
    0xFFE1D8FB,
    <ThemeScheme, Color>{
      ThemeScheme.dark: Color(0xFFE1D8FB),
      ThemeScheme.light: Color(0xFF150C2F),
    },
  );

  static const ColorTone bottomNavigationBarItemColor = ColorTone(
    0xFF150C2F,
    <ThemeScheme, Color>{
      ThemeScheme.light: Color(0xFF150C2F),
      ThemeScheme.dark: Color(0xFFE1D8FB),
    },
  );

  static final MainPalette main = MainPalette();
  static final SupportPalette support = SupportPalette();
}
