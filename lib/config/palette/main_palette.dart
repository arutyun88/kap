import 'dart:ui';

import 'package:kap/config/palette/datatype/color_tone.dart';
import 'package:kap/config/palette/datatype/color_type.dart';

class MainPalette {
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
