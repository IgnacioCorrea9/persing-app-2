import 'package:flutter/material.dart';

class CardCustomizable extends StatelessWidget {
  const CardCustomizable({
    required this.onTap,
    required this.widget,
    required this.color,
    required this.borderColor,
    Key? key,
  }) : super(key: key);

  final void Function() onTap;
  final Widget widget;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color ?? Colors.white,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: borderColor ?? Colors.black.withOpacity(0.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: widget,
        ),
      ),
    );
  }
}
