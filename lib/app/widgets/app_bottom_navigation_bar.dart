import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/app/widgets/app_bottom_navigation_bar_item.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    Key? key,
    required this.icons,
    required this.onTapToItem,
    required this.selectedIndex,
    this.floatingActionButtonIcon,
    this.floatingActionButtonSize = 56.0,
    this.floatingActionButtonOnTap,
  }) : super(key: key);

  final List<IconData> icons;
  final int Function(int) onTapToItem;
  final int selectedIndex;
  final IconData? floatingActionButtonIcon;
  final double floatingActionButtonSize;
  final VoidCallback? floatingActionButtonOnTap;

  @override
  Widget build(BuildContext context) {
    final selectedItemColor = context.theme.bottomNavigationBarTheme.selectedItemColor;

    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(
          bottom: context.mediaQueryPadding.bottom == 0 ? 24.0 : context.mediaQueryPadding.bottom,
        ),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
              clipBehavior: Clip.hardEdge,
              child: ColoredBox(
                color: context.theme.bottomNavigationBarTheme.backgroundColor!.withOpacity(.3),
                child: Row(
                  children: [
                    ...List.generate(
                      icons.length,
                      (index) => AppBottomNavigationBarItem(
                        onTap: () => onTapToItem(index),
                        index: index,
                        selectedIndex: selectedIndex,
                        icon: icons[index],
                      ),
                    ),
                    if (floatingActionButtonIcon != null) SizedBox(width: floatingActionButtonSize),
                  ],
                ),
              ),
            ),
            if (floatingActionButtonIcon != null)
              SizedBox(
                width: 56.0,
                height: 56.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: selectedItemColor,
                    onPressed: floatingActionButtonOnTap,
                    child: Icon(floatingActionButtonIcon, color: context.theme.scaffoldBackgroundColor),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
