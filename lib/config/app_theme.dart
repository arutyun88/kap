import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit/ui_kit.dart';

class AppTheme {
  static ThemeData get light => KitTheme.theme(
        fontFamily: 'Red Hat Display',
        fontMainColor: Palette.mainPalette.primary.tone60,
      ).copyWith(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      );

  static ThemeData get dark => KitTheme.theme(
        fontFamily: 'Panchang',
        // fontFamily: 'Red Hat Display',
        fontMainColor: Palette.neutralPalette.text,
      ).copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      );
}
