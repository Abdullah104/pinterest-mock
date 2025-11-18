import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  final Widget child;

  const Feed({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 9,
      ).add(EdgeInsetsGeometry.only(top: 6)),
      child: child,
    );
  }
}
