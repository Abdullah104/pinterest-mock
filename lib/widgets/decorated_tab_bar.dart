import 'package:flutter/material.dart';

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabBar tabBar;
  final BoxDecoration decoration;

  const DecoratedTabBar({
    super.key,
    required this.tabBar,
    required this.decoration,
  });

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(decoration: decoration)),
        tabBar,
      ],
    );
  }
}
