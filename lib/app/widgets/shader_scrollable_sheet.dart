import 'package:flutter/material.dart';
import 'package:kap/app/widgets/grabber.dart';

class ShaderScrollableSheet extends StatelessWidget {
  const ShaderScrollableSheet({
    Key? key,
    this.fullScreen = false,
    required this.child,
    this.draggableScrollableController,
  }) : super(key: key);

  final bool fullScreen;
  final Widget child;
  final DraggableScrollableController? draggableScrollableController;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: double.infinity,
        child: DraggableScrollableSheet(
          controller: draggableScrollableController,
          maxChildSize: fullScreen ? 1.0 : .98,
          initialChildSize: fullScreen ? 1.0 : .5,
          minChildSize: fullScreen ? 1.0 : .5,
          shouldCloseOnMinExtent: false,
          expand: false,
          snap: true,
          builder: (BuildContext context, ScrollController scrollController) => Scaffold(
            body: ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      final endStart = (rect.height - MediaQuery.of(context).padding.bottom) / rect.height;
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(.05),
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: [0.0, 11.0 / rect.height, 30.0 / rect.height, endStart, 1.0],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      controller: scrollController,
                      child: Padding(
                        padding: EdgeInsets.only(top: 14.0 + 16.0, bottom: MediaQuery.of(context).padding.bottom),
                        child: child,
                      ),
                    ),
                  ),
                  const Align(alignment: AlignmentDirectional.topCenter, child: Grabber()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
