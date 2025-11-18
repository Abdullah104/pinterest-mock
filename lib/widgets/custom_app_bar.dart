import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../presentation/custom_icons_icons.dart';

class CustomAppBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final FocusNode focusNode;
  final void Function(String input) onSearchKeyChanged;
  final VoidCallback onSearchTapped;
  final VoidCallback onCancel;

  const CustomAppBar({
    super.key,
    required this.focusNode,
    required this.onSearchKeyChanged,
    required this.onSearchTapped,
    required this.onCancel,
  });

  @override
  Size get preferredSize => CupertinoNavigationBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      border: Border(bottom: BorderSide(color: Colors.white)),
      middle: Container(
        padding: EdgeInsetsDirectional.only(top: 10),
        height: 50,
        child: CupertinoTextField(
          cursorColor: Color(0xffbd081c),
          decoration: BoxDecoration(
            color: Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.only(left: focusNode.hasFocus ? 14 : 5),
          focusNode: focusNode,
          onChanged: onSearchKeyChanged,
          onTap: onSearchTapped,
          placeholderStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff8c8b8c),
            fontSize: 16,
          ),
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          placeholder: focusNode.hasFocus ? '' : 'Search',
          prefix: AnimatedCrossFade(
            firstChild: Padding(
              padding: const EdgeInsets.only(left: 14, right: 2, bottom: 3),
              child: IconTheme(
                data: IconThemeData(color: Color(0xff8c8b8c), size: 14),
                child: Icon(CustomIcons.magnifyingGlass),
              ),
            ),
            secondChild: SizedBox(),
            crossFadeState: focusNode.hasFocus
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 260),
            alignment: Alignment.centerRight,
          ),
          suffix: AnimatedCrossFade(
            sizeCurve: Curves.ease,
            firstChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: IconTheme(
                data: IconThemeData(color: Color(0xff8c8b8c), size: 22),
                child: Icon(CustomIcons.photoCamera),
              ),
            ),
            secondChild: SizedBox(),
            crossFadeState: focusNode.hasFocus
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 200),
            alignment: Alignment.centerRight,
          ),
        ),
      ),
      trailing: AnimatedCrossFade(
        sizeCurve: Curves.ease,
        firstCurve: focusNode.hasFocus ? Curves.linear : Curves.easeInOut,
        crossFadeState: focusNode.hasFocus
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 200),
        alignment: Alignment.centerLeft,
        firstChild: InkWell(
          onTap: onCancel,
          child: Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        secondChild: Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: IconTheme(
            data: IconThemeData(color: Color(0xff8c8b8c), size: 24),
            child: Icon(CustomIcons.chat),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return CupertinoNavigationBar().shouldFullyObstruct(context);
  }
}
