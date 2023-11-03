import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kap/services/widgets_size_service.dart';

class AppShaderScaffold extends StatelessWidget {
  const AppShaderScaffold({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShaderMask(
        shaderCallback: (rect) {
          const startStart = 0.0;
          final startEnd = context.mediaQueryPadding.top / rect.height;
          final endStart = (rect.height - WidgetsSizeService.to.bottomBarHeight.value) / rect.height;
          final endEnd = (rect.height - (context.mediaQueryPadding.bottom / 4)) / rect.height;
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
            stops: [startStart, startEnd, endStart, endEnd],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: body,
      ),
    );
  }
}
