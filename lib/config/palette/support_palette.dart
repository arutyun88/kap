import 'dart:ui';

import 'package:kap/config/palette/datatype/color_tone.dart';
import 'package:kap/config/palette/datatype/color_type.dart';

class SupportPalette {
  final ColorTone success = const ColorTone(
    0xFF007724,
    <ColorType, Color>{
      ColorType.dark: Color(0xFF007724),
      ColorType.medium: Color(0xFF0DBB42),
      ColorType.light: Color(0xFFB8F1C9),
    },
  );

  final ColorTone warning = const ColorTone(
    0xFFBB8C00,
    <ColorType, Color>{
      ColorType.dark: Color(0xFFBB8C00),
      ColorType.medium: Color(0xFFFFC107),
      ColorType.light: Color(0xFFFFE69C),
    },
  );

  final ColorTone info = const ColorTone(
    0xFF0A4CAA,
    <ColorType, Color>{
      ColorType.dark: Color(0xFF0A4CAA),
      ColorType.medium: Color(0xFF2D7DEE),
      ColorType.light: Color(0xFFBBD7FF),
    },
  );

  final Color danger = const Color(0xFFC1271B);
}
