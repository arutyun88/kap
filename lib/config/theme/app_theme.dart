import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kap/config/palette/palette.dart';

class AppTheme {
  static ThemeData get light => _Theme.theme(
        fontFamily: 'Red Hat Display',
        fontMainColor: Palette.main.primary.dark,
      ).copyWith(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Palette.background.light,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      );

  static ThemeData get dark => _Theme.theme(
        fontFamily: 'Red Hat Display',
        fontMainColor: Palette.main.secondary,
      ).copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Palette.background.dark,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      );
}

abstract class _Theme {
  static ThemeData theme({
    String? fontFamily,
    Color? fontMainColor,
  }) =>
      ThemeData(
        fontFamily: fontFamily,
        textTheme: TextTheme(bodySmall: TextStyle(color: fontMainColor, overflow: TextOverflow.ellipsis)),
      );
}
