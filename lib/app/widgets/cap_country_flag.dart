import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class CapCountryFlag extends StatelessWidget {
  const CapCountryFlag({
    super.key,
    required this.countryCode,
    this.height = 24.0,
    this.borderRadius = 4.0,
  });

  final String countryCode;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: SizedBox(
        width: (height * 1.33) + 1.0,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: Theme.of(context).dividerColor, width: .5),
            ),
            child: CountryFlag.fromCountryCode(
              countryCode,
              width: height * 1.33,
              height: height,
              borderRadius: borderRadius,
            ),
          ),
        ),
      ),
    );
  }
}
