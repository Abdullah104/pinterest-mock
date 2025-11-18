import 'package:flutter/material.dart';

class PopupMenu {
  static Widget settings = Container(
    decoration: BoxDecoration(shape: BoxShape.circle),
    child: Icon(Icons.notifications),
  );
  static Widget logout = Container(
    decoration: BoxDecoration(shape: BoxShape.circle),
    child: Icon(Icons.account_circle),
  );

  static List<Widget> choices = <Widget>[settings, logout];
}
