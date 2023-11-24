import 'package:flutter/material.dart';
import 'package:kap/app/widgets/app_close_button.dart';

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet._({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);

  final Widget child;
  final String title;

  static Future<bool> show(BuildContext context, {required Widget child, required String title}) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => AppBottomSheet._(title: title, child: child),
    ).then((value) => value == true);
  }

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  late final ScrollController _scrollController;
  final _appBarKey = GlobalKey();
  var _appBarHeight = 0.0;
  var _appBarShadowOpacity = 0.0;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() => setState(() => _appBarShadowOpacity = (_scrollController.offset / 100).clamp(.0, .1));

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _appBarHeight = (_appBarKey.currentContext?.size?.height ?? 0.0) + 10.0;
        }));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
      clipBehavior: Clip.hardEdge,
      child: GestureDetector(
        onTap: () {
          if(FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
        },
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: _appBarHeight),
                        widget.child,
                        SizedBox(height: MediaQuery.paddingOf(context).bottom),
                      ],
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 10,
                          spreadRadius: 2,
                          blurStyle: BlurStyle.normal,
                          color: Colors.black12.withOpacity(_appBarShadowOpacity),
                        ),
                      ],
                    ),
                    child: ColoredBox(
                      key: _appBarKey,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0, top: 8.0, bottom: 8.0),
                            child: Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppCloseButton(onTap: onTapToClose),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapToClose() => Navigator.of(context).pop(false);
}
