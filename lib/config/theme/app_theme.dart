import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kap/config/palette/palette.dart';

class AppTheme {
  static ThemeData get light => _Theme.theme(
        defaultTextStyle: TextStyle(color: Palette.main.text.light),
        inputDecorationBorderColor: Palette.main.hint.light,
      ).copyWith(
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

  static ThemeData get dark => _Theme.theme(
        defaultTextStyle: TextStyle(color: Palette.main.text.dark),
        inputDecorationBorderColor: Palette.main.hint.dark,
      ).copyWith(
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
  static ThemeData theme({
    required TextStyle defaultTextStyle,
    required Color inputDecorationBorderColor,
  }) =>
      ThemeData(
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
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: inputDecorationBorderColor),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Palette.accent, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Palette.accent, width: 1.0),
          ),
        ),
        dividerColor: Palette.accent,
        dividerTheme: const DividerThemeData(color: Palette.accent, thickness: 0.5, space: 0.5),
      );
}
