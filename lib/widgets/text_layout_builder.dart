import 'package:flutter/material.dart';

class LayoutBuilderText extends StatelessWidget {
  const LayoutBuilderText({
    key,
    required this.text,
    required this.style,
    this.maxLines = 10,
  }) : super(key: key);

  /// text to display in widget.
  final String text;

  /// style to apply
  final TextStyle style;

  /// maxLines to use if text overflow
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final span = TextSpan(
          text: text,
          style: style,
        );
        final tp = TextPainter(
          text: span,
          textDirection: TextDirection.ltr,
        );
        tp.layout(maxWidth: constraints.maxWidth);

        return RichText(
          text: span,
          maxLines: tp.didExceedMaxLines ? maxLines : null,
          overflow: TextOverflow.fade,
        );
      },
    );
  }
}

/// LayoutBuilder that scales down text until did not exceed maxLines or
/// hit lowestFontSize
class LayoutBuilderTextSizeDown extends StatelessWidget {
  /// Constructor
  const LayoutBuilderTextSizeDown({
    super.key,
    required this.text,
    required this.style,
    this.maxLines = 10,
    this.downValue = 1,
    this.lowestFontSize = 10,
    this.textAlign = TextAlign.left,
  });

  /// text to display in widget.
  final String text;

  /// style to apply
  final TextStyle style;

  /// maxLines to use if text overflow
  final int maxLines;

  /// Value to remove on fontSize inside style argument
  final double downValue;

  /// Lowest fontSize that text will have
  final double lowestFontSize;

  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool keepTrying = true;

        double fontSize =  style.fontSize!;

        while (keepTrying) {
          final span = TextSpan(
            text: text,
            style: style.copyWith(fontSize: fontSize),
          );
          final tp = TextPainter(
            text: span,
            textDirection: TextDirection.ltr,
            maxLines: maxLines,
            textAlign: textAlign,
          );
          tp.layout(maxWidth: constraints.maxWidth);
          if (tp.didExceedMaxLines && fontSize > lowestFontSize) {
            fontSize = fontSize - downValue;
          } else {
            keepTrying = false;
          }
        }
        return RichText(
          text: TextSpan(
            text: text,
            style: style.copyWith(
              fontSize: fontSize,
            ),
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: TextOverflow.fade,
        );
      },
    );
  }
}
