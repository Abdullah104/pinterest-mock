import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../presentation/custom_icons_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _redColor = Color(0xffbd081c);
  final _darkGrey = Color(0xff747474);
  final _images = List.generate(31, (index) => 'assets/images/image_$index.jpg')
    ..shuffle();

  late final FocusNode _focusNode;
  late final TabController _tabController;
  late final ScrollController _hideButtonController;
  late final GlobalKey _scaffoldKey;

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
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CupertinoNavigationBar(
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
            padding: EdgeInsets.only(left: _focusNode.hasFocus ? 14 : 5),
            focusNode: _focusNode,
            onChanged: (input) {
              setState(() {
                _searchKey = input;

                if (kDebugMode) print(_searchKey);
              });
            },
            onTap: () => setState(() {}),
            placeholderStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff8c8b8c),
              fontSize: 16,
            ),
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            placeholder: _focusNode.hasFocus ? '' : 'Search',
            prefix: AnimatedCrossFade(
              firstChild: Padding(
                padding: const EdgeInsets.only(left: 14, right: 2, bottom: 3),
                child: IconTheme(
                  data: IconThemeData(color: Color(0xff8c8b8c), size: 14),
                  child: Icon(CustomIcons.magnifyingGlass),
                ),
              ),
              secondChild: SizedBox(),
              crossFadeState: _focusNode.hasFocus
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 260),
              alignment: Alignment.centerRight,
            ),
            suffix: AnimatedCrossFade(
              sizeCurve: Curves.ease,
              firstChild: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: IconTheme(
                  data: IconThemeData(color: Color(0xff8c8b8c), size: 22),
                  child: Icon(CustomIcons.photoCamera),
                ),
              ),
              secondChild: SizedBox(),
              crossFadeState: _focusNode.hasFocus
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 200),
              alignment: Alignment.centerRight,
            ),
          ),
        ),
        trailing: AnimatedCrossFade(
          sizeCurve: Curves.ease,
          firstCurve: _focusNode.hasFocus ? Curves.linear : Curves.easeInOut,
          crossFadeState: _focusNode.hasFocus
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: Duration(milliseconds: 200),
          alignment: Alignment.centerLeft,
          firstChild: InkWell(
            onTap: () => setState(_focusNode.unfocus),
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
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: _focusNode.hasFocus
            ? Search(controller: _tabController)
            : Feed(
                child: ImagesList(
                  controller: _hideButtonController,
                  images: _images,
                  onLongPressStart: (offset) {
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
                  },
                ),
              ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.only(top: 2),
        color: Colors.white,
        height: _isVisible
            ? Theme.of(context).platform == TargetPlatform.iOS
                  ? 68
                  : 55
            : 0,
        child: SingleChildScrollView(
          child: CupertinoTabBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            activeColor: _selectedIndex == 0 ? _redColor : _darkGrey,
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

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  void _onHideButtonControllerChanged() {
    if (_hideButtonController.position.userScrollDirection == .reverse) {
      setState(() => _isVisible = false);
    }

    if (_hideButtonController.position.userScrollDirection == .forward) {
      setState(() => _isVisible = true);
    }
  }
}

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

class CustomTabBar extends TabBar {
  const CustomTabBar({
    super.key,
    required super.tabs,
    super.controller,
    super.indicatorColor,
  });
}

class ImagesList extends StatelessWidget {
  final ScrollController controller;
  final void Function(Offset offset) onLongPressStart;
  final List<String> images;

  const ImagesList({
    super.key,
    required this.controller,
    required this.onLongPressStart,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      controller: controller,
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 8,
      itemCount: images.length,
      itemBuilder: (_, index) => Column(
        children: [
          Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Colors.transparent,
              onTap: () {
                if (kDebugMode) print("Tapped");
              },
              child: GestureDetector(
                onLongPressStart: (details) {
                  final box = context.findRenderObject() as RenderBox;
                  final local = box.globalToLocal(details.globalPosition);

                  onLongPressStart(local);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Card(
                      elevation: 0,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(6),
                      ),
                      child: Image.asset(images[index]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () => _imageModalBottomSheet(context),
                          child: IconTheme(
                            data: IconThemeData(size: 18),
                            child: Icon(Icons.more_horiz),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _imageModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 360,
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 4),
                    width: double.infinity,
                    height: 45,
                    child: Center(
                      child: Text(
                        'Options',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 2,
                    top: 2,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: IconTheme(
                        data: IconThemeData(color: Colors.grey.shade600),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 14, bottom: 10),
                child: InkWell(
                  onTap: () {
                    if (kDebugMode) print('tapped');
                  },
                  child: Row(
                    children: [
                      IconTheme(
                        data: IconThemeData(color: Colors.black87),
                        child: Icon(Icons.save_alt),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontWeight: .bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 14, bottom: 10),
                child: Row(
                  children: [
                    IconTheme(
                      data: IconThemeData(color: Colors.black87),
                      child: Icon(Icons.send),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Send",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 14, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconTheme(
                          data: IconThemeData(color: Colors.black87),
                          child: Icon(Icons.close),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Hide",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 34, top: 4),
                          child: Text(
                            "See fewer Pins like this",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 14, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconTheme(
                          data: IconThemeData(color: Colors.black87),
                          child: Icon(Icons.report),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Report",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 34, top: 4),
                          child: Text(
                            "This goes against community guidlines",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

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
