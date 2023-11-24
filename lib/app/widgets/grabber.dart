import 'package:flutter/material.dart';

class Grabber extends StatelessWidget {
  const Grabber({
    Key? key,
    this.backgroundColor,
  }) : super(key: key);

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15.0,
      width: double.maxFinite,
      child: ColoredBox(
        color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 14.0,
              width: double.maxFinite,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 3.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.5),
                    clipBehavior: Clip.hardEdge,
                    child: ColoredBox(
                      color: Theme.of(context).bottomSheetTheme.dragHandleColor ?? Colors.grey,
                      child: const SizedBox(height: double.maxFinite, width: 36),
                    ),
                  ),
                ),
              ),
            ),
            ColoredBox(color: Colors.grey.withOpacity(.5), child: const SizedBox(height: 1, width: double.infinity)),
          ],
        ),
      ),
    );
  }
}
