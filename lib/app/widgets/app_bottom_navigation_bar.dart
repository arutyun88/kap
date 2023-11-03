import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    this.itemSize = 56.0,
    required this.icons,
    required this.onTapToItem,
    required this.selectedIndex,
    this.floatingActionButtonIcon,
    this.floatingActionButtonSize = 72.0,
    this.floatingActionButtonOnTap,
  }) : assert(icons.length >= 2 && icons.length <= 5, 'the number of elements must be at least 2 and no more than 5');

  final double itemSize;
  final List<IconData> icons;
  final int Function(int) onTapToItem;
  final int selectedIndex;
  final IconData? floatingActionButtonIcon;
  final double floatingActionButtonSize;
  final VoidCallback? floatingActionButtonOnTap;

  @override
  Widget build(BuildContext context) {
    final selectedItemColor = context.theme.bottomNavigationBarTheme.selectedItemColor;
    final borderRadius = BorderRadius.circular(16.0);
    final borderRadiusWithFloating = borderRadius.copyWith(
      topRight: Radius.circular(floatingActionButtonSize / 2),
      bottomRight: Radius.circular(floatingActionButtonSize / 2),
    );

    const padding = 12.0;
    final itemWidth =
        (context.width - (padding * 2) - (floatingActionButtonIcon == null ? 0.0 : floatingActionButtonSize)) /
            icons.length;

    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: padding).copyWith(
          bottom: context.mediaQueryPadding.bottom == 0 ? padding : context.mediaQueryPadding.bottom,
        ),
        child: Stack(
          alignment: icons.length.isOdd ? AlignmentDirectional.centerEnd : AlignmentDirectional.center,
          children: [
            ClipRRect(
              borderRadius: floatingActionButtonIcon != null && icons.length.isOdd
                  ? borderRadiusWithFloating
                  : borderRadius,
              clipBehavior: Clip.hardEdge,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: ColoredBox(
                  color: context.theme.bottomNavigationBarTheme.backgroundColor!.withOpacity(.2),
                  child: Row(
                    children: List.generate(
                      icons.length,
                      (index) => Padding(
                        padding: floatingActionButtonIcon == null
                            ? EdgeInsets.zero
                            : EdgeInsets.only(
                                right: icons.length.isOdd
                                    ? index == (icons.length - 1)
                                        ? floatingActionButtonSize
                                        : 0.0
                                    : index == ((icons.length / 2) - 1)
                                        ? floatingActionButtonSize
                                        : 0.0,
                              ),
                        child: _AppBottomNavigationBarItem(
                          itemSize: itemSize,
                          onTap: () => onTapToItem(index),
                          index: index,
                          selectedIndex: selectedIndex,
                          icon: icons[index],
                          width: itemWidth,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (floatingActionButtonIcon != null)
              SizedBox(
                width: floatingActionButtonSize,
                height: floatingActionButtonSize,
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

class _AppBottomNavigationBarItem extends StatelessWidget {
  const _AppBottomNavigationBarItem({
    Key? key,
    required this.itemSize,
    required this.onTap,
    required this.selectedIndex,
    required this.index,
    required this.icon,
    required this.width,
  }) : super(key: key);

  final double itemSize;
  final VoidCallback onTap;
  final int selectedIndex;
  final int index;
  final IconData icon;
  final double width;

  @override
  Widget build(BuildContext context) {
    final selectedItemColor = context.theme.bottomNavigationBarTheme.selectedItemColor;
    final unselectedItemColor = context.theme.bottomNavigationBarTheme.unselectedItemColor;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: itemSize,
        width: width,
        child: Icon(icon, color: selectedIndex == index ? selectedItemColor : unselectedItemColor, size: 24.0),
      ),
    );
  }
}
