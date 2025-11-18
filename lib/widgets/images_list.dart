import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
