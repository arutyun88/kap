import 'package:flutter/material.dart';
import 'package:kap/config/l10n/custom_app_localizations.dart';

class AppDialog extends StatelessWidget {
  const AppDialog._({
    required this.message,
  });

  final String message;

  static Future error(
    BuildContext context, {
    required String message,
  }) =>
      showDialog(
        context: context,
        builder: (context) => AppDialog._(message: message),
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
            Text(message, style: Theme.of(context).textTheme.bodyMedium),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: OutlinedButton(
                onPressed: Navigator.of(context).pop,
                child: Text(context.dictionary.closeButtonTitle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
