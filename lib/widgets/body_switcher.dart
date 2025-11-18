import 'package:flutter/cupertino.dart';

class BodySwitcher extends StatelessWidget {
  final Widget body;

  const BodySwitcher({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: body,
    );
  }
}
