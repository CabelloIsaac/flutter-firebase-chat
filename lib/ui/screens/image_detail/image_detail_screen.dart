import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDetailScreen extends StatelessWidget {
  static final String route = "/ImageDetailScreen";
  @override
  Widget build(BuildContext context) {
    final url = ModalRoute.of(context).settings.arguments;

    final _pageSize = MediaQuery.of(context).size.height;
    final _notifySize = MediaQuery.of(context).padding.top;
    final _appBarSize = AppBar().preferredSize.height;
    final width = MediaQuery.of(context).size.width;
    final height = _pageSize - (_notifySize + _appBarSize);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          child: Hero(
            tag: url.toString(),
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: url,
                height: height,
                width: width,
                errorWidget: (context, a, b) {
                  return Image.asset("res/images/not-found.png");
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
