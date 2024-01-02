import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:kap/app/widgets/cap_country_button.dart';

class CapPhoneField extends StatelessWidget {
  const CapPhoneField({
    super.key,
    required this.controller,
    required this.country,
    required this.onTapToFlag,
    required this.onChange,
  });

  final TextEditingController controller;
  final CountryWithPhoneCode country;
  final VoidCallback onTapToFlag;
  final void Function(String) onChange;

  double _calculateTextWidth(BuildContext context, String text, TextStyle? textStyle) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumberMask = country.phoneMaskFixedLineInternational
        .substring(
          country.phoneMaskFixedLineInternational.indexOf(' '),
          country.phoneMaskFixedLineInternational.length,
        )
        .trim();

    final style = Theme.of(context).textTheme.headlineSmall;
    final width = _calculateTextWidth(context, phoneNumberMask, style);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CapCountryButton(
          countryCode: country.countryCode,
          phoneCode: country.phoneCode,
          onTap: onTapToFlag,
          style: style,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width),
            child: TextField(
              controller: controller,
              enabled: true,
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
              style: style,
              cursorHeight: style?.fontSize,
              inputFormatters: [
                LibPhonenumberTextFormatter(
                  phoneNumberFormat: PhoneNumberFormat.international,
                  shouldKeepCursorAtEndOfInput: false,
                  country: country,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
