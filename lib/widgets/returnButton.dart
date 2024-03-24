import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back),
    );
  }
}
