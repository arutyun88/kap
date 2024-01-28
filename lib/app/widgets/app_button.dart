import 'package:flutter/material.dart';
import 'package:kap/config/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton._({
    this.onTap,
    required this.title,
    required _ButtonType buttonType,
  }) : _buttonType = buttonType;

  final VoidCallback? onTap;
  final String title;
  final _ButtonType _buttonType;

  factory AppButton.accent({
    required String title,
    VoidCallback? onTap,
  }) =>
      AppButton._(
        title: title,
        onTap: onTap,
        buttonType: _ButtonType.accent,
      );

  factory AppButton.secondary({
    required String title,
    VoidCallback? onTap,
  }) =>
      AppButton._(
        title: title,
        onTap: onTap,
        buttonType: _ButtonType.secondary,
      );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          splashColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
                color: _buttonType == _ButtonType.accent
                    ? Theme.of(context).accent.withOpacity(onTap == null ? .3 : 1.0)
                    : Theme.of(context).buttonTheme.colorScheme?.secondary),
            width: double.infinity,
            child: Text(
              title,
              style: onTap == null ? textTheme?.copyWith(color: textTheme.color?.withOpacity(.5)) : textTheme,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}

enum _ButtonType { accent, secondary }
