import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kap/config/palette/palette.dart';

class CodeField extends StatefulWidget {
  const CodeField({
    super.key,
    this.count = 6,
    required this.controller,
  });

  final int count;
  final TextEditingController controller;

  @override
  State<CodeField> createState() => _CodeFieldState();
}

class _CodeFieldState extends State<CodeField> {

  @override
  void initState() {
    super.initState();
    final list = List.generate(widget.count, (index) => '0').toList();
    String str = '';
    for (var element in list) {
      str += element;
    }
    widget.controller.text = str;
  }

  double _calculateTextWidth(BuildContext context, TextStyle? textStyle) {
    final text = TextSpan(text: '0', style: textStyle);
    final TextPainter textPainter = TextPainter(text: text, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headlineLarge;
    final width = _calculateTextWidth(context, style);

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          widget.count,
          (index) => Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: SizedBox(
                width: width * 2,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Palette.accent, width: 1)),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Palette.accent, width: 1)),
                    disabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide(color: Palette.accent.withOpacity(.5), width: .5)),
                  ),
                  textAlign: TextAlign.center,
                  style: style,
                  cursorHeight: style?.fontSize,
                  onChanged: (value) {
                    if (value != '') {
                      String nStr = '';
                      final spl = widget.controller.text.split('');
                      spl[index] = value;
                      for (var element in spl) {
                        nStr += element;
                      }
                      widget.controller.text = nStr;
                    } else {
                      String nStr = '';
                      final spl = widget.controller.text.split('');
                      spl[index] = '0';
                      for (var element in spl) {
                        nStr += element;
                      }
                      widget.controller.text = nStr;
                    }
                    if (value.length == 1 && index != widget.count - 1) {
                      FocusManager.instance.primaryFocus?.nextFocus();
                    } else if (value.isEmpty && index != 0) {
                      FocusManager.instance.primaryFocus?.previousFocus();
                    }
                  },
                  inputFormatters: [LengthLimitingTextInputFormatter(1)],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
