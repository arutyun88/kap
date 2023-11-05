import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/services/widgets_size_service.dart';

class AppBottomNavigationBar extends StatefulWidget {
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
  final void Function(int) onTapToItem;
  final int selectedIndex;
  final IconData? floatingActionButtonIcon;
  final double floatingActionButtonSize;
  final VoidCallback? floatingActionButtonOnTap;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  final GlobalKey _childKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getChildSize());
  }

  void _getChildSize() => WidgetsSizeService.to
      .setBottomBarHeight((_childKey.currentContext?.findRenderObject() as RenderBox).size.height);

  @override
  Widget build(BuildContext context) {
    final selectedItemColor = context.theme.bottomNavigationBarTheme.selectedItemColor;
    final borderRadius = BorderRadius.circular(10.0);
    final borderRadiusWithFloating = borderRadius.copyWith(
      topRight: Radius.circular(widget.floatingActionButtonSize / 2),
      bottomRight: Radius.circular(widget.floatingActionButtonSize / 2),
    );

    const padding = 12.0;
    final itemWidth = (context.width -
            (padding * 2) -
            (widget.floatingActionButtonIcon == null ? 0.0 : widget.floatingActionButtonSize)) /
        widget.icons.length;

    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Padding(
        key: _childKey,
        padding: const EdgeInsets.symmetric(horizontal: padding).copyWith(
          bottom: context.mediaQueryPadding.bottom == 0 ? padding : context.mediaQueryPadding.bottom,
        ),
        child: Stack(
          alignment: widget.icons.length.isOdd ? AlignmentDirectional.centerEnd : AlignmentDirectional.center,
          children: [
            ClipRRect(
              borderRadius: widget.floatingActionButtonIcon != null && widget.icons.length.isOdd
                  ? borderRadiusWithFloating
                  : borderRadius,
              clipBehavior: Clip.hardEdge,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: ColoredBox(
                  color: context.theme.bottomNavigationBarTheme.backgroundColor!.withOpacity(.2),
                  child: Row(
                    children: List.generate(
                      widget.icons.length,
                      (index) => Padding(
                        padding: widget.floatingActionButtonIcon == null
                            ? EdgeInsets.zero
                            : EdgeInsets.only(
                                right: widget.icons.length.isOdd
                                    ? index == (widget.icons.length - 1)
                                        ? widget.floatingActionButtonSize
                                        : 0.0
                                    : index == ((widget.icons.length / 2) - 1)
                                        ? widget.floatingActionButtonSize
                                        : 0.0,
                              ),
                        child: _AppBottomNavigationBarItem(
                          itemSize: widget.itemSize,
                          onTap: () => widget.onTapToItem(index),
                          index: index,
                          selectedIndex: widget.selectedIndex,
                          icon: widget.icons[index],
                          width: itemWidth,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.floatingActionButtonIcon != null)
              SizedBox(
                width: widget.floatingActionButtonSize,
                height: widget.floatingActionButtonSize,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: selectedItemColor,
                    onPressed: widget.floatingActionButtonOnTap,
                    child: Icon(widget.floatingActionButtonIcon, color: context.theme.scaffoldBackgroundColor),
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
