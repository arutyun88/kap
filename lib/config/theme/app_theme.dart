import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kap/config/palette/palette.dart';

class AppTheme {
  static ThemeData get light => _Theme.theme(defaultTextStyle: TextStyle(color: Palette.main.text.light)).copyWith(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Palette.background.light,
        appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Palette.bottomNavigationBarBackgroundColor.light,
          elevation: 0.0,
          selectedItemColor: Palette.bottomNavigationBarItemColor.light,
          unselectedItemColor: Palette.bottomNavigationBarItemColor.light.withOpacity(.4),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          dragHandleColor: Palette.main.grabber.light,
          modalBackgroundColor: Colors.transparent,
        ),
      );

  static ThemeData get dark => _Theme.theme(defaultTextStyle: TextStyle(color: Palette.main.text.dark)).copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Palette.background.dark,
        appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Palette.bottomNavigationBarBackgroundColor.dark,
          elevation: 0.0,
          selectedItemColor: Palette.bottomNavigationBarItemColor.dark,
          unselectedItemColor: Palette.bottomNavigationBarItemColor.dark.withOpacity(.5),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          dragHandleColor: Palette.main.grabber.dark,
          modalBackgroundColor: Colors.transparent,
        ),
      );
}

abstract class _Theme {
  static ThemeData theme({required TextStyle defaultTextStyle}) => ThemeData(
        fontFamily: 'Red Hat Display',
        textTheme: TextTheme(
          displayLarge: defaultTextStyle,
          displayMedium: defaultTextStyle,
          displaySmall: defaultTextStyle,
          headlineLarge: defaultTextStyle,
          headlineMedium: defaultTextStyle,
          headlineSmall: defaultTextStyle,
          titleLarge: defaultTextStyle,
          titleMedium: defaultTextStyle,
          titleSmall: defaultTextStyle,
          bodyLarge: defaultTextStyle,
          bodyMedium: defaultTextStyle,
          bodySmall: defaultTextStyle,
          labelLarge: defaultTextStyle,
          labelMedium: defaultTextStyle,
          labelSmall: defaultTextStyle,
        ),
      );
}
