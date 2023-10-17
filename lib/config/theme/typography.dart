import 'package:flutter/material.dart';

extension Typography on TextTheme {
  TextStyle get action => bodySmall!.copyWith(fontSize: 24.0, fontWeight: FontWeight.w500, height: 32.0 / 24.0);

  TextStyle get caption => bodySmall!.copyWith(fontSize: 20.0, fontWeight: FontWeight.w500, height: 28.0 / 20.0);

  TextStyle get heading => bodySmall!.copyWith(fontSize: 36.0, fontWeight: FontWeight.w500, height: 40.0 / 36.0);

  TextStyle get body => bodySmall!.copyWith(fontSize: 24.0, fontWeight: FontWeight.w500, height: 32.0 / 24.0);

  TextStyle get underline => bodySmall!
      .copyWith(fontSize: 24.0, fontWeight: FontWeight.w500, height: 32.0 / 24.0, decoration: TextDecoration.underline);

  TextStyle get through => bodySmall!.copyWith(
      fontSize: 20.0, fontWeight: FontWeight.w400, height: 28.0 / 20.0, decoration: TextDecoration.lineThrough);
}
