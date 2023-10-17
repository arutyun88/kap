import 'dart:ui';

import 'package:kap/config/palette/datatype/color_tone.dart';
import 'package:kap/config/palette/datatype/color_type.dart';
import 'package:kap/config/palette/main_palette.dart';
import 'package:kap/config/palette/support_palette.dart';

abstract class Palette {
  static const ColorTone background = ColorTone(
    0xFF150C2F,
    <ColorType, Color>{
      ColorType.dark: Color(0xFF150C2F),
      ColorType.medium: Color(0xFF150C2F),
      ColorType.light: Color(0xFFE1D8FB),
    },
  );

  static final MainPalette main = MainPalette();
  static final SupportPalette support = SupportPalette();
}
