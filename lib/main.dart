import 'package:flutter/material.dart';

import 'routes/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pinterest mock',
      theme: ThemeData(
        primaryColor: Color(0xffbd081c),
        canvasColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
