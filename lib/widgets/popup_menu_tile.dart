// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// MenuTile used in PopUpMenu
class PopUpMenuTile extends StatelessWidget {
  /// COnstructor
  const PopUpMenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.isActive = false,
  });

  /// Icon to show on tile
  final IconData icon;

  /// Tile's tittle
  final String title;

  /// To visually enable or disable element
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: isActive
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).primaryColor,
              ),
        ),
        const SizedBox(
          width: 8,
        ),
        Icon(
          icon,
          color: isActive
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).primaryColor,
          size: 21,
        ),
      ],
    );
  }
}
