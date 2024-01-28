import 'package:flutter/material.dart';
import 'package:kap/app/widgets/app_button.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';

class AppDialog extends StatelessWidget {
  const AppDialog._({
    required this.message,
    this.isOptions = false,
  });

  final String message;
  final bool isOptions;

  static Future error(
    BuildContext context, {
    required String message,
  }) =>
      showDialog(
        context: context,
        builder: (context) => AppDialog._(message: message),
      );

  static Future stay(
    BuildContext context, {
    required String message,
  }) =>
      showDialog(
        context: context,
        builder: (context) => AppDialog._(message: message, isOptions: true),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isOptions)
                    Flexible(
                      child: AppButton.secondary(
                        onTap: () => Navigator.of(context).pop(true),
                        title: context.dictionary.continueButtonTitle,
                      ),
                    ),
                  Flexible(
                    child: AppButton.accent(
                      onTap: () => Navigator.of(context).pop(false),
                      title: isOptions ? context.dictionary.cancelButtonTitle : context.dictionary.continueButton,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
