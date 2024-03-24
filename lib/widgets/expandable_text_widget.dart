import 'package:flutter/material.dart';

/// Text widget with 'Ver más' option
class ExpandableTextWidget extends StatelessWidget {
  ExpandableTextWidget({
    super.key,
    required this.text,
  });
  final ValueNotifier<int> _maxLines = ValueNotifier(3);

  final String text;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return ValueListenableBuilder(
      valueListenable: _maxLines,
      builder: (BuildContext context, int value, Widget? child) {
        return LayoutBuilder(
          builder: (context, size) {
            // Build the textSpan

            var span = TextSpan(
              text: text,
              style: TextStyle(fontSize: 14),
            );

            // Use a textPainter to determine if it will exceed max lines
            var tp = TextPainter(
              maxLines: value,
              textAlign: TextAlign.justify,
              textDirection: TextDirection.ltr,
              text: span,
            );

            // trigger it to layout
            tp.layout(maxWidth: size.maxWidth);

            // whether the text overflowed or not
            var exceeded = tp.didExceedMaxLines;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  span,
                  maxLines: value,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                ),
                if (exceeded)
                  InkWell(
                    onTap: () {
                      _maxLines.value = 5;
                    },
                    child: Text(
                      'Ver más',
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  )
              ],
            );
          },
        );
      },
    );
  }
}
