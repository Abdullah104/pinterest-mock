import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../popup_menu.dart';
import '../widgets/body_switcher.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_navigation_bar.dart';
import '../widgets/feed.dart';
import '../widgets/images_list.dart';
import '../widgets/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _images = List.generate(31, (index) => 'assets/images/image_$index.jpg')
    ..shuffle();

  late final FocusNode _focusNode;
  late final TabController _tabController;
  late final ScrollController _hideButtonController;

  var _selectedIndex = 0;
  var _searchKey = '';
  var _isVisible = true;

  late Offset _position;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    _hideButtonController = ScrollController()
      ..addListener(_onHideButtonControllerChanged);

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        focusNode: _focusNode,
        onSearchKeyChanged: _onSearchKeyChanged,
        onSearchTapped: _onSearchTapped,
        onCancel: _onCancel,
      ),
      body: BodySwitcher(
        body: _focusNode.hasFocus
            ? Search(controller: _tabController)
            : Feed(
                child: ImagesList(
                  controller: _hideButtonController,
                  images: _images,
                  onLongPressStart: _onImageLongPressStart,
                ),
              ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        visible: _isVisible,
        currentIndex: _selectedIndex,
        onTap: _onNavigationBarItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _hideButtonController
      ..removeListener(_onHideButtonControllerChanged)
      ..dispose();
    _tabController.dispose();

    super.dispose();
  }

  void _onNavigationBarItemTapped(int index) =>
      setState(() => _selectedIndex = index);

  void _onHideButtonControllerChanged() {
    if (_hideButtonController.position.userScrollDirection == .reverse) {
      setState(() => _isVisible = false);
    }

    if (_hideButtonController.position.userScrollDirection == .forward) {
      setState(() => _isVisible = true);
    }
  }

  void _onSearchKeyChanged(String input) {
    setState(() {
      _searchKey = input;

      if (kDebugMode) print(_searchKey);
    });
  }

  void _onSearchTapped() => setState(() {});

  void _onCancel() => setState(_focusNode.unfocus);

  void _onImageLongPressStart(Offset offset) {
    setState(() => _position = offset);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        _position.dx,
        _position.dy,
        _position.dx,
        _position.dy,
      ),
      items: PopupMenu.choices
          .map((choice) => PopupMenuItem<Widget>(child: choice))
          .toList(),
    );
  }
}
