import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:kap/app/widgets/cap_country_flag.dart';
import 'package:kap/app/widgets/cap_vertical_divider.dart';

class CapCountryButton extends StatefulWidget {
  const CapCountryButton({
    super.key,
    required this.onChange,
    required this.countryCode,
    required this.phoneCode,
    this.style,
  });

  final Function(CountryWithPhoneCode) onChange;
  final String countryCode;
  final String phoneCode;
  final TextStyle? style;

  @override
  State<CapCountryButton> createState() => _CapCountryButtonState();
}

class _CapCountryButtonState extends State<CapCountryButton> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CapCountryFlag(countryCode: widget.countryCode, height: 24),
          Text('+${widget.phoneCode}', style: widget.style),
          const CapVerticalDivider(),
        ],
      ),
    );
  }
}
