import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../presentation/custom_icons_icons.dart';

class CustomNavigationBar extends StatelessWidget {
  final bool visible;
  final int currentIndex;
  final void Function(int index) onTap;

  const CustomNavigationBar({
    super.key,
    required this.visible,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const redColor = Color(0xffbd081c);
    const darkGrey = Color(0xff747474);

    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      padding: EdgeInsets.only(top: 2),
      color: Colors.white,
      height: visible
          ? Theme.of(context).platform == TargetPlatform.iOS
                ? 68
                : 55
          : 0,
      child: SingleChildScrollView(
        child: CupertinoTabBar(
          currentIndex: currentIndex,
          onTap: onTap,
          activeColor: currentIndex == 0 ? redColor : darkGrey,
          inactiveColor: Colors.grey,
          backgroundColor: Colors.white,
          border: Border(top: BorderSide(color: Colors.white)),
          items: [
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.pinterest),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Following',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Saved',
            ),
          ],
        ),
      ),
    );
  }
}
