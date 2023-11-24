import 'dart:ui';

import 'package:kap/config/palette/datatype/color_tone.dart';
import 'package:kap/config/palette/datatype/color_type.dart';

class MainPalette {
  final ColorTone text = const ColorTone(
    0xFFFFFFFF,
    <ColorType, Color>{
      ColorType.dark: Color(0xFFFFFFFF),
      ColorType.light: Color(0xFF000000),
    },
  );

  final ColorTone grabber =  ColorTone(
    0xFFFFFFFF,
    <ColorType, Color>{
      ColorType.dark: const Color(0xFFEBEBF5).withOpacity(.3),
      ColorType.light: const Color(0xFF3C3C42).withOpacity(.3),
    },
  );

  final ColorTone hint =  ColorTone(
    0xFFFFFFFF,
    <ColorType, Color>{
      ColorType.dark: const Color(0xFFEBEBF5).withOpacity(.5),
      ColorType.light: const Color(0xFF3C3C42).withOpacity(.5),
    },
  );

  final ColorTone primary = const ColorTone(
    0xFF150C2F,
    <ColorType, Color>{
      ColorType.dark: Color(0xFF150C2F),
      ColorType.medium: Color(0xFF2A195F),
      ColorType.light: Color(0xFF3F258E),
    },
  );

  final ColorTone secondary = const ColorTone(
    0xFF172D2E,
    <ColorType, Color>{
      ColorType.dark: Color(0xFF172D2E),
      ColorType.medium: Color(0xFF2D595C),
      ColorType.light: Color(0xFF44868A),
    },
  );

  final ColorTone tertiary = const ColorTone(
    0xFF172D2E,
    <ColorType, Color>{
      ColorType.dark: Color(0xFF0B2416),
      ColorType.medium: Color(0xFF17482C),
      ColorType.light: Color(0xFF226B41),
    },
  );
}
