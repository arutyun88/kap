import 'package:flutter/material.dart';
import 'package:kap/app/widgets/cap_country_flag.dart';
import 'package:kap/app/widgets/cap_vertical_divider.dart';

class CapCountryButton extends StatelessWidget {
  const CapCountryButton({
    super.key,
    required this.onTap,
    required this.countryCode,
    required this.phoneCode,
    this.style,
  });

  final VoidCallback onTap;
  final String countryCode;
  final String phoneCode;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CountryWidget(
            style: style,
            phoneCode: phoneCode,
            countryCode: countryCode,
          ),
          const CapVerticalDivider(),
        ],
      ),
    );
  }
}

class _CountryWidget extends StatelessWidget {
  const _CountryWidget({
    required this.style,
    required this.countryCode,
    required this.phoneCode,
  });

  final TextStyle? style;
  final String countryCode;
  final String phoneCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [CapCountryFlag(countryCode: countryCode, height: 24), Text('+$phoneCode', style: style)],
    );
  }
}
