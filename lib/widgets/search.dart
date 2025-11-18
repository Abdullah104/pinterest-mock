import 'package:flutter/material.dart';

import 'custom_tab_bar.dart';
import 'decorated_tab_bar.dart';

class Search extends StatelessWidget {
  final TabController controller;

  const Search({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      children: [
        DecoratedTabBar(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100, width: 2),
            ),
          ),
          tabBar: CustomTabBar(
            controller: controller,
            indicatorColor: Colors.black87,
            tabs: [
              Tab(
                child: Text(
                  'Top',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Yours',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'People',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
