import 'dart:ui';

import 'package:kap/config/palette/datatype/color_tone.dart';
import 'package:kap/config/theme/theme_scheme.dart';

class MainPalette {
  final ColorTone text = const ColorTone(
    0xFFFFFFFF,
    <ThemeScheme, Color>{
      ThemeScheme.dark: Color(0xFFFFFFFF),
      ThemeScheme.light: Color(0xFF000000),
    },
  );

  final ColorTone grabber =  ColorTone(
    0xFFFFFFFF,
    <ThemeScheme, Color>{
      ThemeScheme.dark: const Color(0xFFEBEBF5).withOpacity(.3),
      ThemeScheme.light: const Color(0xFF3C3C42).withOpacity(.3),
    },
  );

  final ColorTone hint =  ColorTone(
    0xFFFFFFFF,
    <ThemeScheme, Color>{
      ThemeScheme.dark: const Color(0xFFEBEBF5).withOpacity(.5),
      ThemeScheme.light: const Color(0xFF3C3C42).withOpacity(.5),
    },
  );

  final ColorTone primary = const ColorTone(
    0xFF150C2F,
    <ThemeScheme, Color>{
      ThemeScheme.dark: Color(0xFF150C2F),
      ThemeScheme.light: Color(0xFF3F258E),
    },
  );

  final ColorTone secondary = const ColorTone(
    0xFF172D2E,
    <ThemeScheme, Color>{
      ThemeScheme.dark: Color(0xFF172D2E),
      ThemeScheme.light: Color(0xFF44868A),
    },
  );

  final ColorTone tertiary = const ColorTone(
    0xFF172D2E,
    <ThemeScheme, Color>{
      ThemeScheme.dark: Color(0xFF0B2416),
      ThemeScheme.light: Color(0xFF226B41),
    },
  );
}
