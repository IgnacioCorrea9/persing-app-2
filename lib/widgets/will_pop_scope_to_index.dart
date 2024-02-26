import 'package:flutter/material.dart';
import 'package:persing/screens/index/index_screen.dart';

/// Widget to wrap other widgets and control pop scope to IndexPage
class WillPopScopeToIndexScreen extends StatelessWidget {
  /// Constructor
  const WillPopScopeToIndexScreen({
    key,
    required this.child,
    this.backToIndex = 0,
  });

  /// Widget to show inside this element, normally a scaffold
  final Widget child;

  /// IndexScreen index to return
  final int backToIndex;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => IndexScreen(
              initialIndex: backToIndex,
            ),
          ),
        );
        return Future.value(true);
      },
      child: child,
    );
  }
}
